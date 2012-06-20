# Class: apache
#
# This class installs Apache
#
# Parameters:
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

  $user  = $apache::params::user,
  $group = $apache::params::group,

) inherits apache::params {

  #-----------------------------------------------------------------------------

  package { 'apache':
    ensure => 'installed',
    name   => $apache::params::apache_name,
  }

  #-----------------------------------------------------------------------------

  file { 'apache_vdir':
    ensure  => 'directory',
    path    => $apache::params::apache_vdir,
    recurse => true,
    purge   => true,
    notify  => Service['apache'],
    require => Package['apache'],
  }

  if $apache::params::apache_config {
    file { 'apache_config':
      path      => $apache::params::apache_config,
      owner     => 'root',
      group     => 'root',
      mode      => 644,
      content   => template('apache/apache2.conf.erb'),
      require   => Package['apache'],
    }
  }

  if $apache::params::apache_ports_dir {
    file { 'apache_ports':
      path      => $apache::params::apache_ports_dir,
      ensure    => 'directory',
      owner     => 'root',
      group     => 'root',
      mode      => 755,
      require   => Package['apache'],
    }
  }

  if $apache::params::apache_vars {
    file { 'apache_vars':
      path      => $apache::params::apache_vars,
      owner     => 'root',
      group     => 'root',
      mode      => 644,
      content   => template('apache/envvars.erb'),
      require   => Package['apache'],
    }
  }

  #-----------------------------------------------------------------------------

  service { 'apache':
    ensure    => running,
    name      => $apache::params::apache_name,
    enable    => true,
    subscribe => [
      Package['apache'],
      File['apache_config'],
      File['apache_ports'],
      File['apache_vars'],
    ],
  }
}
