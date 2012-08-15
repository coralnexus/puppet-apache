
class apache::mod::wsgi (

  $module_ensure = $apache::params::module_ensure,
  $lib_packages  = [ $apache::params::mod_wsgi_package ],
  $lib_ensure    = $apache::params::module_lib_ensure,

) {

  #-----------------------------------------------------------------------------

  apache::module { 'wsgi':
    module_ensure => $module_ensure,
    lib_packages  => $lib_packages,
    lib_ensure    => $lib_ensure,
  }
}
