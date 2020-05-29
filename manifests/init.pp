# rsync
# test
# @summary install rsync package and create rsync::put/get instances
# @param package_ensure ensure parameter for package-resource
# @param manage_package whether to manage the package-resource
# @param puts rsync::put instances to create
# @param gets rsync::get instances to create
# @example
#   class { 'rsync':
#     package_ensure => 'latest'
#   }
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
