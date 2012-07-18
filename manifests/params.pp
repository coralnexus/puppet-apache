# Class: apache::params
#
# This class manages Apache parameters (supports Hiera if it exists)
#
class apache::params {

  include apache::default

  #-----------------------------------------------------------------------------
  # General configurations

  if $::hiera_exists {
    $apache_ensure                      = hiera('apache_ensure', $apache::default::apache_ensure)
    $use_dev                            = hiera('apache_use_dev', $apache::default::use_dev)
    $apache_dev_ensure                  = hiera('apache_dev_ensure', $apache::default::apache_dev_ensure)
    $conf_ensure                        = hiera('apache_conf_ensure', $apache::default::conf_ensure)
    $module_ensure                      = hiera('apache_module_ensure', $apache::default::module_ensure)
    $module_lib_ensure                  = hiera('apache_module_lib_ensure', $apache::default::module_lib_ensure)
    $modules                            = hiera_array('apache_modules', $apache::default::modules)
    $user                               = hiera('apache_user', $apache::default::user)
    $group                              = hiera('apache_group', $apache::default::group)
    $locale                             = hiera('apache_locale', $apache::default::locale)
    $web_home                           = hiera('apache_web_home', $apache::default::web_home)
    $access_file                        = hiera('apache_access_file', $apache::default::access_file)
    $timeout                            = hiera('apache_timeout', $apache::default::timeout)
    $keepalive                          = hiera('apache_keepalive', $apache::default::keepalive)
    $max_keepalive_requests             = hiera('apache_max_keepalive_requests', $apache::default::max_keepalive_requests)
    $keepalive_timeout                  = hiera('apache_keepalive_timeout', $apache::default::keepalive_timeout)
    $mpm_prefork_start_servers          = hiera('apache_mpm_prefork_start_servers', $apache::default::mpm_prefork_start_servers)
    $mpm_prefork_min_spare_servers      = hiera('apache_mpm_prefork_min_spare_servers', $apache::default::mpm_prefork_min_spare_servers)
    $mpm_prefork_max_spare_servers      = hiera('apache_mpm_prefork_max_spare_servers', $apache::default::mpm_prefork_max_spare_servers)
    $mpm_prefork_max_clients            = hiera('apache_mpm_prefork_max_clients', $apache::default::mpm_prefork_max_clients)
    $mpm_prefork_max_requests_per_child = hiera('apache_mpm_prefork_max_requests_per_child', $apache::default::mpm_prefork_max_requests_per_child)
    $mpm_worker_start_servers           = hiera('apache_mpm_worker_start_servers', $apache::default::mpm_worker_start_servers)
    $mpm_worker_min_spare_threads       = hiera('apache_mpm_worker_min_spare_threads', $apache::default::mpm_worker_min_spare_threads)
    $mpm_worker_max_spare_threads       = hiera('apache_mpm_worker_max_spare_threads', $apache::default::mpm_worker_max_spare_threads)
    $mpm_worker_thread_limit            = hiera('apache_mpm_worker_thread_limit', $apache::default::mpm_worker_thread_limit)
    $mpm_worker_threads_per_child       = hiera('apache_mpm_worker_threads_per_child', $apache::default::mpm_worker_threads_per_child)
    $mpm_worker_max_clients             = hiera('apache_mpm_worker_max_clients', $apache::default::mpm_worker_max_clients)
    $mpm_worker_max_requests_per_child  = hiera('apache_mpm_worker_max_requests_per_child', $apache::default::mpm_worker_max_requests_per_child)
    $mpm_event_start_servers            = hiera('apache_mpm_event_start_servers', $apache::default::mpm_event_start_servers)
    $mpm_event_min_spare_threads        = hiera('apache_mpm_event_min_spare_threads', $apache::default::mpm_event_min_spare_threads)
    $mpm_event_max_spare_threads        = hiera('apache_mpm_event_max_spare_threads', $apache::default::mpm_event_max_spare_threads)
    $mpm_event_thread_limit             = hiera('apache_mpm_event_thread_limit', $apache::default::mpm_event_thread_limit)
    $mpm_event_threads_per_child        = hiera('apache_mpm_event_threads_per_child', $apache::default::mpm_event_threads_per_child)
    $mpm_event_max_clients              = hiera('apache_mpm_event_max_clients', $apache::default::mpm_event_max_clients)
    $mpm_event_max_requests_per_child   = hiera('apache_mpm_event_max_requests_per_child', $apache::default::mpm_event_max_requests_per_child)
    $ulimit_max_files                   = hiera('apache_ulimit_max_files', $apache::default::ulimit_max_files)
    $restricted_files                   = hiera('apache_restricted_files', $apache::default::restricted_files)
    $default_type                       = hiera('apache_default_type', $apache::default::default_type)
    $hostname_lookups                   = hiera('apache_hostname_lookups', $apache::default::hostname_lookups)
    $log_level                          = hiera('apache_log_level', $apache::default::log_level)
    $log_formats                        = hiera('apache_log_formats', $apache::default::log_formats)
    $server_name                        = hiera('apache_server_name', $apache::default::server_name)
    $aliases                            = hiera('apache_aliases', $apache::default::aliases)
    $admin_email                        = hiera('apache_admin_email', $apache::default::admin_email)
    $doc_root                           = hiera('apache_doc_root', $apache::default::doc_root)
    $proxy_url                          = hiera('apache_proxy_url', $apache::default::proxy_url)
    $destination                        = hiera('apache_destination', $apache::default::destination)
    $configure_firewall                 = hiera('apache_configure_firewall', $apache::default::configure_firewall)
    $default_port                       = hiera('apache_default_port', $apache::default::default_port)
    $http_port                          = hiera('apache_http_port', $apache::default::http_port)
    $use_ssl                            = hiera('apache_use_ssl', $apache::default::use_ssl)
    $ssl_cert                           = hiera('apache_ssl_cert', $apache::default::ssl_cert)
    $ssl_key                            = hiera('apache_ssl_key', $apache::default::ssl_key)
    $https_port                         = hiera('apache_https_port', $apache::default::https_port)
    $priority                           = hiera('apache_priority', $apache::default::priority)
    $options                            = hiera('apache_options', $apache::default::options)
    $vhost_ip                           = hiera('apache_vhost_ip', $apache::default::vhost_ip)
    $error_log_level                    = hiera('apache_error_log_level', $apache::default::error_log_level)
    $rewrite_log_level                  = hiera('apache_rewrite_log_level', $apache::default::rewrite_log_level)
  }
  else {
    $apache_ensure                      = $apache::default::apache_ensure
    $use_dev                            = $apache::default::use_dev
    $apache_dev_ensure                  = $apache::default::apache_dev_ensure
    $conf_ensure                        = $apache::default::conf_ensure
    $module_ensure                      = $apache::default::module_ensure
    $module_lib_ensure                  = $apache::default::module_lib_ensure
    $modules                            = $apache::default::modules
    $user                               = $apache::default::user
    $group                              = $apache::default::group
    $locale                             = $apache::default::locale
    $web_home                           = $apache::default::web_home
    $access_file                        = $apache::default::access_file
    $timeout                            = $apache::default::timeout
    $keepalive                          = $apache::default::keepalive
    $max_keepalive_requests             = $apache::default::max_keepalive_requests
    $keepalive_timeout                  = $apache::default::keepalive_timeout
    $mpm_prefork_start_servers          = $apache::default::mpm_prefork_start_servers
    $mpm_prefork_min_spare_servers      = $apache::default::mpm_prefork_min_spare_servers
    $mpm_prefork_max_spare_servers      = $apache::default::mpm_prefork_max_spare_servers
    $mpm_prefork_max_clients            = $apache::default::mpm_prefork_max_clients
    $mpm_prefork_max_requests_per_child = $apache::default::mpm_prefork_max_requests_per_child
    $mpm_worker_start_servers           = $apache::default::mpm_worker_start_servers
    $mpm_worker_min_spare_threads       = $apache::default::mpm_worker_min_spare_threads
    $mpm_worker_max_spare_threads       = $apache::default::mpm_worker_max_spare_threads
    $mpm_worker_thread_limit            = $apache::default::mpm_worker_thread_limit
    $mpm_worker_threads_per_child       = $apache::default::mpm_worker_threads_per_child
    $mpm_worker_max_clients             = $apache::default::mpm_worker_max_clients
    $mpm_worker_max_requests_per_child  = $apache::default::mpm_worker_max_requests_per_child
    $mpm_event_start_servers            = $apache::default::mpm_event_start_servers
    $mpm_event_min_spare_threads        = $apache::default::mpm_event_min_spare_threads
    $mpm_event_max_spare_threads        = $apache::default::mpm_event_max_spare_threads
    $mpm_event_thread_limit             = $apache::default::mpm_event_thread_limit
    $mpm_event_threads_per_child        = $apache::default::mpm_event_threads_per_child
    $mpm_event_max_clients              = $apache::default::mpm_event_max_clients
    $mpm_event_max_requests_per_child   = $apache::default::mpm_event_max_requests_per_child
    $ulimit_max_files                   = $apache::default::ulimit_max_files
    $restricted_files                   = $apache::default::restricted_files
    $default_type                       = $apache::default::default_type
    $hostname_lookups                   = $apache::default::hostname_lookups
    $log_level                          = $apache::default::log_level
    $log_formats                        = $apache::default::log_formats
    $server_name                        = $apache::default::server_name
    $aliases                            = $apache::default::aliases
    $admin_email                        = $apache::default::admin_email
    $doc_root                           = $apache::default::doc_root
    $proxy_url                          = $apache::default::proxy_url
    $destination                        = $apache::default::destination
    $configure_firewall                 = $apache::default::configure_firewall
    $default_port                       = $apache::default::default_port
    $http_port                          = $apache::default::http_port
    $use_ssl                            = $apache::default::use_ssl
    $ssl_cert                           = $apache::default::ssl_cert
    $ssl_key                            = $apache::default::ssl_key
    $https_port                         = $apache::default::https_port
    $priority                           = $apache::default::priority
    $options                            = $apache::default::options
    $vhost_ip                           = $apache::default::vhost_ip
    $error_log_level                    = $apache::default::error_log_level
    $rewrite_log_level                  = $apache::default::rewrite_log_level
  }

  #-----------------------------------------------------------------------------
  # Operating System specific configurations

  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific': {
      $os_apache_package     = 'httpd'
      $os_apache_dev_package = 'httpd-devel'

      $os_mod_php_package    = 'php'
      $os_mod_python_package = 'mod_python'
      $os_mod_wsgi_package   = 'mod_wsgi'

      $os_apache_vhost_dir   = '/etc/httpd/conf.d'
      $os_apache_conf_dir    = $os_apache_vhost_dir
      $os_apache_log_dir     = '/var/log/httpd'
      $os_apache_run_dir     = '/var/run/httpd'
      $os_apache_lock_dir    = '/var/lock/httpd'

      fail("The apache module currently needs some configuration work for ${::operatingsystem}")
    }
    'ubuntu', 'debian': {
      $os_apache_package          = 'apache2'
      $os_apache_dev_package      = ['libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev']

      $os_mod_php_package         = 'libapache2-mod-php5'
      $os_mod_python_package      = 'libapache2-mod-python'
      $os_mod_wsgi_package        = 'libapache2-mod-wsgi'

      $os_apache_config_dir       = '/etc/apache2'
      $os_apache_config_file      = "${os_apache_config_dir}/apache2.conf"
      $os_apache_vhost_dir        = "${os_apache_config_dir}/sites-enabled"
      $os_apache_conf_dir         = "${os_apache_config_dir}/conf.d"
      $os_apache_vars_file        = "${os_apache_config_dir}/envvars"
      $os_apache_log_dir          = '/var/log/apache2'
      $os_apache_run_dir          = '/var/run/apache2'
      $os_apache_lock_dir         = '/var/lock/apache2'

      $os_config_template         = 'apache/debian.apache2.conf.erb'
      $os_vars_template           = 'apache/debian.envvars.erb'

      $os_port_template           = 'apache/ports.conf.erb'
      $os_vhost_template          = 'apache/vhost.conf.erb'
      $os_vhost_proxy_template    = 'apache/vhost-proxy.conf.erb'
      $os_vhost_redirect_template = 'apache/vhost-redirect.conf.erb'
    }
    default: {
      fail("The apache module is not currently supported on ${::operatingsystem}")
    }
  }
}
