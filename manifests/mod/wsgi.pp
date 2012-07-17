
class apache::mod::wsgi {
  include apache

  apache::module {'wsgi':
    lib_package => $apache::params::os_mod_wsgi_package,
  }
}
