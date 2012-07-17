
class apache::mod::wsgi {
  apache::module {'wsgi':
    lib_package => $apache::params::os_mod_wsgi_package,
  }
}
