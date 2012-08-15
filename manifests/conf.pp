
define apache::conf (

  $content  = '',
  $ensure   = 'present',
  $conf_dir = $apache::params::conf_dir,

) {

  #-----------------------------------------------------------------------------

  $config_file = "${conf_dir}/${name}.conf"

  file { $config_file:
    ensure  => $ensure,
    content => $content,
    mode    => '0644',
    require => File['apache_conf_dir'],
    notify  => Service['apache'],
  }
}
