# rsync::put
# @summary put files via rsync ussing exec
# @param source source to copy from
# @param path path to copy to
# @param user username on remote system
# @param keyfile path to ssh key used to connect to remote host
# @param timeout timeout in seconds
# @param options commandline options to pass to rsync (-a)
# @example
#   rsync::put { '${rsyncDestHost}:/repo/foo':
#     user    => 'user',
#     source  => "/repo/foo/",
#   }
define rsync::put (
  String           $source,
  Optional[String] $path    = undef,
  Optional[String] $user    = undef,
  String           $keyfile = "/home/${user}/.ssh/id_rsa",
  String           $timeout = '900',
  String           $options = '-a'
) {

  if $user {
    $myuseropt = "-e 'ssh -i ${keyfile} -l ${user}'"
    $myuser = "${user}@"
  } else {
    $myuseropt = undef
    $myuser = undef
  }

  if $path {
    $mypath = $path
  } else {
    $mypath = $name
  }

  $rsync_options = join(
    delete_undef_values([$options, $myuseropt, $source, "${myuser}${mypath}"]), ' ')

  exec { "rsync ${name}":
    command => "rsync -q ${rsync_options}",
    path    => [ '/bin', '/usr/bin' ],
    # perform a dry-run to determine if anything needs to be updated
    # this ensures that we only actually create a Puppet event if something needs to
    # be updated
    # TODO - it may make senes to do an actual run here (instead of a dry run)
    #        and relace the command with an echo statement or something to ensure
    #        that we only actually run rsync once
    onlyif  => "test `rsync --dry-run --itemize-changes ${rsync_options} | wc -l` -gt 0",
    timeout => $timeout,
  }
}
