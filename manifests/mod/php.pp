
class apache::mod::php {
  apache::module {'php5':
    lib_package => $apache::params::os_mod_php_package,
  }
}
