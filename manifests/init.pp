# Class: apache
#
# This class installs, configures, and manages Apache
#
# Supports Hiera
#
# Parameters:
#
#  See <examples/params.json> for Hiera keys.
#
# Actions:
#   - Install Apache
#   - Configure Apache
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
class apache (

  $package                            = $apache::params::os_apache_package,
  $package_ensure                     = $apache::params::apache_package_ensure,
  $service                            = $apache::params::os_apache_service,
  $service_ensure                     = $apache::params::apache_service_ensure,
  $use_dev                            = $apache::params::use_dev,
  $dev_ensure                         = $apache::params::apache_dev_ensure,
  $dev_package                        = $apache::params::os_apache_dev_package,
  $modules                            = $apache::params::modules,
  $config_file                        = $apache::params::os_apache_config_file,
  $vars_file                          = $apache::params::os_apache_vars_file,
  $vhost_dir                          = $apache::params::os_apache_vhost_dir,
  $conf_dir                           = $apache::params::os_apache_conf_dir,
  $log_dir                            = $apache::params::os_apache_log_dir,
  $run_dir                            = $apache::params::os_apache_run_dir,
  $lock_dir                           = $apache::params::os_apache_lock_dir,
  $user                               = $apache::params::user,
  $group                              = $apache::params::group,
  $locale                             = $apache::params::locale,
  $access_file                        = $apache::params::access_file,
  $timeout                            = $apache::params::timeout,
  $keepalive                          = $apache::params::keepalive,
  $max_keepalive_requests             = $apache::params::max_keepalive_requests,
  $keepalive_timeout                  = $apache::params::keepalive_timeout,
  $mpm_prefork_start_servers          = $apache::params::mpm_prefork_start_servers,
  $mpm_prefork_min_spare_servers      = $apache::params::mpm_prefork_min_spare_servers,
  $mpm_prefork_max_spare_servers      = $apache::params::mpm_prefork_max_spare_servers,
  $mpm_prefork_max_clients            = $apache::params::mpm_prefork_max_clients,
  $mpm_prefork_max_requests_per_child = $apache::params::mpm_prefork_max_requests_per_child,
  $mpm_worker_start_servers           = $apache::params::mpm_worker_start_servers,
  $mpm_worker_min_spare_threads       = $apache::params::mpm_worker_min_spare_threads,
  $mpm_worker_max_spare_threads       = $apache::params::mpm_worker_max_spare_threads,
  $mpm_worker_thread_limit            = $apache::params::mpm_worker_thread_limit,
  $mpm_worker_threads_per_child       = $apache::params::mpm_worker_threads_per_child,
  $mpm_worker_max_clients             = $apache::params::mpm_worker_max_clients,
  $mpm_worker_max_requests_per_child  = $apache::params::mpm_worker_max_requests_per_child,
  $mpm_event_start_servers            = $apache::params::mpm_event_start_servers,
  $mpm_event_min_spare_threads        = $apache::params::mpm_event_min_spare_threads,
  $mpm_event_max_spare_threads        = $apache::params::mpm_event_max_spare_threads,
  $mpm_event_thread_limit             = $apache::params::mpm_event_thread_limit,
  $mpm_event_threads_per_child        = $apache::params::mpm_event_threads_per_child,
  $mpm_event_max_clients              = $apache::params::mpm_event_max_clients,
  $mpm_event_max_requests_per_child   = $apache::params::mpm_event_max_requests_per_child,
  $ulimit_max_files                   = $apache::params::ulimit_max_files,
  $restricted_files                   = $apache::params::restricted_files,
  $default_type                       = $apache::params::default_type,
  $log_formats                        = $apache::params::log_formats,
  $config_template                    = $apache::params::os_config_template,
  $vars_template                      = $apache::params::os_vars_template,

) inherits apache::params {

  #-----------------------------------------------------------------------------
  # Installation

  package { 'apache':
    name   => $package,
    ensure => $package_ensure,
  }

  if $use_dev == 'true' {
    package { 'apache_dev_package':
      name    => $dev_package,
      ensure  => $dev_ensure,
      require => Package['apache'],
    }
  }

  if ! empty($modules) {
    apache::module { $modules:
      require => Package['apache'],
    }
  }

  #-----------------------------------------------------------------------------
  # Configuration

  file { 'apache_vhost_dir':
    path    => $vhost_dir,
    ensure  => directory,
    recurse => true,
    purge   => true,
    require => Package['apache'],
    notify  => Service['apache'],
  }

  if $config_file {
    file { 'apache_config_file':
      path    => $config_file,
      ensure  => present,
      content => template($config_template),
      require => Package['apache'],
      notify  => Service['apache'],
    }
  }

  if $conf_dir {
    file { 'apache_conf_dir':
      path      => $conf_dir,
      ensure    => directory,
      require   => Package['apache'],
      notify    => Service['apache'],
    }
  }

  if $vars_file {
    file { 'apache_vars_file':
      path      => $vars_file,
      ensure    => present,
      content   => template($vars_template),
      require   => Package['apache'],
      notify    => Service['apache'],
    }
  }

  #-----------------------------------------------------------------------------
  # Service

  service { 'apache':
    name    => $service,
    ensure  => $service_ensure,
    enable  => true,
    require => Package['apache'],
  }
}
