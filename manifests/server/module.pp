# Definition: rsync::server::module
#
# sets up a rsync server
#
# @param path path to data
# @param comment rsync comment
# @param read_only yes||no, defaults to yes
# @param write_only yes||no, defaults to no
# @param use_chroot yes|no, defaults to undef
# @param list yes||no, defaults to yes
# @param uid  uid of rsync server, defaults to 0
# @param gid  gid of rsync server, defaults to 0
# @param incoming_chmod incoming file mode, defaults to 0644
# @param outgoing_chmod outgoing file mode, defaults to 0644
# @param max_connections maximum number of simultaneous connections allowed, defaults to 0
# @param lock_file file used to support the max connections parameter, defaults to /var/run/rsyncd.lock only needed if max_connections > 0
# @param secrets_file path to the file that contains the username:password pairs used for authenticating this module
# @param auth_users list of usernames that will be allowed to connect to this module
# @param hosts_allow list of patterns allowed to connect to this module (man 5 rsyncd.conf for details)
# @param hosts_deny list of patterns allowed to connect to this module (man 5 rsyncd.conf for details)
# @param transfer_logging parameter enables per-file logging of downloads and uploads in a format
#      somewhat similar to that used by ftp daemons.
# @param log_format This parameter allows you to specify the format used for logging file transfers when transfer
#      logging is enabled. See the rsyncd.conf documentation for more details.
# @param refuse_options list of rsync command line options that will be refused by your rsync daemon.
# @param log_file  log messages to the indicated file rather than using syslog
# @param dont_compress wildcard patterns that should not be compressed when pulling files from the daemon
# @param order concat::fragment order
# @param exclude space-separated list of daemon exclude patterns.
# @param pre_xfer_exec command to be run before and/or after the transfer.
# @param post_xfer_exec command to be run before and/or after the transfer.
# @param ignore_nonreadable
# @param reverse_lookup Controls whether the daemon performs a reverse lookup on the client’s IP address to determine its hostname,
#      which is used for "hosts allow"/"hosts deny" checks and the "%h" log escape.
# @example
#   rsync::server::module { 'repo':
#     path    => $base,
#     require => File[$base],
#   }
define rsync::server::module (
  String                   $path,
  String                   $order              = '10',
  Optional[String]         $comment            = undef,
  Boolean                  $read_only          = true,
  Boolean                  $write_only         = false,
  Boolean                  $list               = true,
  String                   $uid                = '0',
  String                   $gid                = '0',
  Variant[Boolean,String]  $incoming_chmod     = '0644',
  Variant[Boolean,String]  $outgoing_chmod     = '0644',
  Variant[Integer,String]  $max_connections    = '0',
  String                   $lock_file          = '/var/run/rsyncd.lock',
  Boolean                  $use_chroot         = true,
  Optional[String]         $secrets_file       = undef,
  Optional[Array]          $exclude            = undef,
  Optional[Array]          $auth_users         = undef,
  Optional[Array]          $hosts_allow        = undef,
  Optional[Array]          $hosts_deny         = undef,
  Optional[String]         $pre_xfer_exec      = undef,
  Optional[String]         $post_xfer_exec     = undef,
  Boolean                  $transfer_logging   = false,
  Optional[String]         $log_format         = undef,
  Optional[Array]          $refuse_options     = undef,
  Boolean                  $ignore_nonreadable = false,
  Optional[String]         $log_file           = undef,
  Optional[Array[String]]  $dont_compress      = undef,
  Boolean                  $reverse_lookup     = true,)  {

  concat::fragment { "frag-${name}":
    content => epp('rsync/module.epp',{
      'name'               => $name,
      'path'               => $path,
      'order'              => $order,
      'comment'            => $comment,
      'read_only'          => $read_only,
      'write_only'         => $write_only,
      'use_chroot'         => $use_chroot,
      'list'               => $list,
      'uid'                => $uid,
      'gid'                => $gid,
      'incoming_chmod'     => $incoming_chmod,
      'outgoing_chmod'     => $outgoing_chmod,
      'max_connections'    => $max_connections,
      'lock_file'          => $lock_file,
      'secrets_file'       => $secrets_file,
      'exclude'            => $exclude,
      'auth_users'         => $auth_users,
      'hosts_allow'        => $hosts_allow,
      'hosts_deny'         => $hosts_deny,
      'transfer_logging'   => $transfer_logging,
      'log_format'         => $log_format,
      'refuse_options'     => $refuse_options,
      'ignore_nonreadable' => $ignore_nonreadable,
      'log_file'           => $log_file,
      'pre_xfer_exec'      => $pre_xfer_exec,
      'post_xfer_exec'     => $post_xfer_exec,
      'dont_compress'      => $dont_compress,
      'reverse_lookup'     => $reverse_lookup,
    }),
    target  => $rsync::server::conf_file,
    order   => $order,
  }
}
