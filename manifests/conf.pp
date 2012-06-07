
define apache::conf (

  $content = '',
  $source  = '',
  $ensure  = 'present',

) {

  #-----------------------------------------------------------------------------

  $config_path = "${apache::params::apache_etc}/conf.d/${name}.conf"

  File {
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    require => File['apache_vdir'],
    notify  => Service['apache'],
  }

  if $content {
    file { $config_path: content => $content, }
  }
  elsif $source {
    file { $config_path: source => $source, }
  }
}
