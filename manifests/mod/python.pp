
class apache::mod::python (

  $module_ensure = $apache::params::module_ensure,
  $lib_packages  = [ $apache::params::mod_python_package ],
  $lib_ensure    = $apache::params::module_lib_ensure,

) {

  #-----------------------------------------------------------------------------

  apache::module {'python':
    module_ensure => $module_ensure,
    lib_packages  => $lib_packages,
    lib_ensure    => $lib_ensure,
  }
}
