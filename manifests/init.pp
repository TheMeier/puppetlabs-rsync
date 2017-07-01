# Class: rsync
#
# This module manages rsync
#
class rsync(
  String  $package_ensure    = 'installed',
  Boolean $manage_package    = true,
  Hash    $puts              = {},
  Hash    $gets              = {},
) {

  if $manage_package {
    package { 'rsync':
      ensure => $package_ensure,
    } -> Rsync::Get<| |>
  }

  create_resources(rsync::put, $puts)
  create_resources(rsync::get, $gets)
}
