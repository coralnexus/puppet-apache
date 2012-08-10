
define apache::module (

  $module_ensure = $apache::params::module_ensure,
  $lib_package   = '',
  $lib_ensure    = $apache::params::module_lib_ensure,

) {

  include apache

  #-----------------------------------------------------------------------------

  if $lib_package {
    package { $lib_package:
      ensure  => $lib_ensure,
      require => Package['apache'];
    }
  }

  a2mod { $name:
    ensure  => $module_ensure,
    require => Package['apache'],
  }
}
