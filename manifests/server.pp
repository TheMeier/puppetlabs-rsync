# Class: rsync::server
#
# The rsync server. Supports both standard rsync as well as rsync over ssh
#
# Requires:
#   class xinetd if use_xinetd is set to true
#   class rsync
#
class rsync::server(
  Boolean                                   $use_xinetd      = true,
  String                                    $address         = '0.0.0.0',
  Variant[Boolean,Enum['yes','no','1','0']] $use_chroot      = true,
  String                                    $uid             = 'nobody',
  String                                    $gid             = 'nobody',
  String                                    $port            = '873',
  Hash                                      $modules         = {},
  String                                    $syslog_facility = 'local3',
) inherits rsync {

  case $facts['os']['family'] {
    'Debian': {
      $conf_file = '/etc/rsyncd.conf'
      $servicename = 'rsync'
    }
    'Suse': {
      $conf_file = '/etc/rsyncd.conf'
      $servicename = 'rsyncd'
    }
    'RedHat': {
      $conf_file = '/etc/rsyncd.conf'
      $servicename = 'rsyncd'
    }
    'FreeBSD': {
      $conf_file = '/usr/local/etc/rsync/rsyncd.conf'
      $servicename = 'rsyncd'
    }
    default: {
      $conf_file = '/etc/rsync.conf'
      $servicename = 'rsync'
    }
  }

  if $use_xinetd {
    include xinetd
    xinetd::service { 'rsync':
      bind        => $address,
      port        => $port,
      server      => '/usr/bin/rsync',
      server_args => "--daemon --config ${conf_file}",
      require     => Package['rsync'],
    }
  } else {
    service { $servicename:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => Concat[$conf_file],
    }

  if ( $facts['os']['family'] == 'Debian' ) {
      file { '/etc/default/rsync':
        source => 'puppet:///modules/rsync/defaults',
        notify => Service['rsync'],
      }
    }
  }

  concat { $conf_file: }

  # Template uses:
  # - $use_chroot
  # - $address
  concat::fragment { 'rsyncd_conf_header':
    target  => $conf_file,
    content => epp('rsync/header.epp'),
    order   => '00_header',
  }

  create_resources(rsync::server::module, $modules)

}
