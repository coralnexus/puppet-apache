
define apache::module (

  $module_ensure = $apache::params::module_ensure,
  $lib_packages  = [],
  $lib_ensure    = $apache::params::module_lib_ensure,

) {

  include apache

  #-----------------------------------------------------------------------------

  if ! empty($lib_packages) {
    package { $lib_packages:
      ensure  => $lib_ensure,
      require => Package['apache'];
    }
  }

  a2mod { $name:
    ensure  => $module_ensure,
    require => Package['apache'],
  }
}
