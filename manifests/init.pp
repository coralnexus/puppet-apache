# Class: apache
#
# This class installs Apache
#
# Parameters:
#
#  $http_port     = $apache::params::http_port,
#  $https_port    = $apache::params::https_port,
#  $apache_vdir   = $apache::params::apache_vdir,
#  $apache_config = $apache::params::apache_config,
#  $apache_ports  = $apache::params::apache_ports,
#  $apache_vars   = $apache::params::apache_vars,
#
# Actions:
#   - Install Apache
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
class apache (

  $http_port     = $apache::params::http_port,
  $https_port    = $apache::params::https_port,
  $apache_vdir   = $apache::params::apache_vdir,
  $apache_config = $apache::params::apache_config,
  $apache_ports  = $apache::params::apache_ports,
  $apache_vars   = $apache::params::apache_vars,

) inherits apache::params {

  #-----------------------------------------------------------------------------

  package { 'apache':
    ensure => installed,
    name   => $apache::params::apache_name,
  }

  #-----------------------------------------------------------------------------

  file { 'apache_vdir':
    ensure  => directory,
    path    => $apache_vdir,
    recurse => true,
    purge   => true,
    notify  => Service['apache'],
    require => Package['apache'],
  }

  file { 'apache_config':
    path      => $apache_config,
    owner     => 'root',
    group     => 'root',
    mode      => 644,
    content   => template('apache/apache2.conf.erb'),
    require   => Package['apache'],
  }

  file { 'apache_ports':
    path      => $apache_ports,
    owner     => 'root',
    group     => 'root',
    mode      => 644,
    content   => template('apache/ports.conf.erb'),
    require   => Package['apache'],
  }

  file { 'apache_vars':
    path      => $apache_vars,
    owner     => 'root',
    group     => 'root',
    mode      => 644,
    content   => template('apache/envvars.erb'),
    require   => Package['apache'],
  }

  #-----------------------------------------------------------------------------

  service { 'apache':
    ensure    => running,
    name      => $apache::params::apache_name,
    enable    => true,
    require   => Package['apache'],
    subscribe => [
      Package['apache'],
      File['apache_config'],
      File['apache_ports'],
      File['apache_vars'],
    ],
  }
}
