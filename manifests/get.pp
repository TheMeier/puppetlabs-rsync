# rysync::get
# @summary get files via rsync ussing exec
# @param source source to copy from
# @param path path to copy to
# @param user username on remote system
# @param keyfile path to ssh key used to connect to remote host
# @param timeout timeout in seconds
# @param execuser user to run the command (passed to exec)
# @param options commandline options to pass to rsync (-a)
# @param onlyif Condition to run the rsync command
# @example
#   rsync::get { '/foo':
#     source  => "rsync://${rsync_server}/repo/foo/",
#     require => File['/foo'],
#   }
define rsync::get (
  String            $source,
  String            $path          = $name,
  Optional[String]  $user          = undef,
  String            $keyfile       = "/home/${user}/.ssh/id_rsa",
  String            $timeout       = '900',
  String            $execuser      = 'root',
  String            $options       = '-a',
  Optional[String]  $onlyif        = undef,
) {

  if $user {
    $myuser = "-e 'ssh -i ${keyfile} -l ${user}' ${user}@"
  } else {
    $myuser = undef
  }

  $rsync_options = join(
    delete_undef_values([$options, "${myuser}${source}", $path]), ' ')

  if !$onlyif {
    $onlyif_real = "test `rsync --dry-run --itemize-changes ${rsync_options} | wc -l` -gt 0"
  } else {
    $onlyif_real = $onlyif
  }


  exec { "rsync ${name}":
    command => "rsync -q ${rsync_options}",
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    user    => $execuser,
    # perform a dry-run to determine if anything needs to be updated
    # this ensures that we only actually create a Puppet event if something needs to
    # be updated
    # TODO - it may make senes to do an actual run here (instead of a dry run)
    #        and relace the command with an echo statement or something to ensure
    #        that we only actually run rsync once
    onlyif  => $onlyif_real,
    timeout => $timeout,
  }
}
