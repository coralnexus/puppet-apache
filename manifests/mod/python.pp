
class apache::mod::python {
  include apache

  apache::module {'python':
    lib_package => $apache::params::os_mod_python_package,
  }
}
