
define apache::conf (

  $content = '',
  $source  = '',
  $ensure  = $apache::params::conf_ensure,

) {

  #-----------------------------------------------------------------------------

  $config_file = "${apache::params::os_apache_conf_dir}/${name}.conf"

  File {
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    require => File['apache_conf_dir'],
    notify  => Service['apache'],
  }

  if $content {
    file { $config_file: content => $content, }
  }
  elsif $source {
    file { $config_file: source => $source, }
  }
}
