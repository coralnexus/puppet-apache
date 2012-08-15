
class apache::mod::php (

  $module_ensure = $apache::params::module_ensure,
  $lib_packages  = [ $apache::params::mod_php_package ],
  $lib_ensure    = $apache::params::module_lib_ensure,

) {

  #-----------------------------------------------------------------------------

  apache::module {'php5':
    module_ensure => $module_ensure,
    lib_packages  => $lib_packages,
    lib_ensure    => $lib_ensure,
  }
}
