
class apache::params inherits apache::default {

  $package                            = module_param('package')
  $package_ensure                     = module_param('package_ensure')

  $init_command                       = module_param('init_command')

  $service                            = module_param('service')
  $service_ensure                     = module_param('service_ensure')
  $use_dev                            = module_param('use_dev')
  $dev_packages                       = module_param('dev_packages')
  $dev_ensure                         = module_param('dev_ensure')
  $module_lib_ensure                  = module_param('module_lib_ensure')
  $mod_php_package                    = module_param('mod_php_package')
  $mod_python_package                 = module_param('mod_python_package')
  $mod_wsgi_package                   = module_param('mod_wsgi_package')
  $modules                            = module_array('modules')
  $module_ensure                      = module_param('module_ensure')

  #---

  $config_dir                         = module_param('config_dir')
  $config_file                        = module_param('config_file')
  $config_template                    = module_param('config_template')
  $port_template                      = module_param('port_template')
  $vhost_dir                          = module_param('vhost_dir')
  $vhost_enable_dir                   = module_param('vhost_enable_dir')
  $conf_dir                           = module_param('conf_dir')
  $vars_file                          = module_param('vars_file')
  $vars_template                      = module_param('vars_template')
  $log_dir                            = module_param('log_dir')
  $log_mode                           = module_param('log_mode')
  $run_dir                            = module_param('run_dir')
  $lock_dir                           = module_param('lock_dir')
  $ssl_cert_dir                       = module_param('ssl_cert_dir')
  $ssl_key_dir                        = module_param('ssl_key_dir')
  $web_home                           = module_param('web_home')
  $web_home_mode                      = module_param('web_home_mode')
  $access_file                        = module_param('access_file')

  #---

  $default_vhost_names                = module_array('default_vhost_names')

  #---

  $user                               = module_param('user')
  $group                              = module_param('group')
  $ssl_group                          = module_param('ssl_group')
  $locale                             = module_param('locale')

  #---

  $timeout                            = module_param('timeout')
  $keepalive                          = module_param('keepalive')
  $max_keepalive_requests             = module_param('max_keepalive_requests')
  $keepalive_timeout                  = module_param('keepalive_timeout')

  $mpm_prefork_start_servers          = module_param('mpm_prefork_start_servers')
  $mpm_prefork_min_spare_servers      = module_param('mpm_prefork_min_spare_servers')
  $mpm_prefork_max_spare_servers      = module_param('mpm_prefork_max_spare_servers')
  $mpm_prefork_max_clients            = module_param('mpm_prefork_max_clients')
  $mpm_prefork_max_requests_per_child = module_param('mpm_prefork_max_requests_per_child')

  $mpm_worker_start_servers           = module_param('mpm_worker_start_servers')
  $mpm_worker_min_spare_threads       = module_param('mpm_worker_min_spare_threads')
  $mpm_worker_max_spare_threads       = module_param('mpm_worker_max_spare_threads')
  $mpm_worker_thread_limit            = module_param('mpm_worker_thread_limit')
  $mpm_worker_threads_per_child       = module_param('mpm_worker_threads_per_child')
  $mpm_worker_max_clients             = module_param('mpm_worker_max_clients')
  $mpm_worker_max_requests_per_child  = module_param('mpm_worker_max_requests_per_child')

  $mpm_event_start_servers            = module_param('mpm_event_start_servers')
  $mpm_event_min_spare_threads        = module_param('mpm_event_min_spare_threads')
  $mpm_event_max_spare_threads        = module_param('mpm_event_max_spare_threads')
  $mpm_event_thread_limit             = module_param('mpm_event_thread_limit')
  $mpm_event_threads_per_child        = module_param('mpm_event_threads_per_child')
  $mpm_event_max_clients              = module_param('mpm_event_max_clients')
  $mpm_event_max_requests_per_child   = module_param('mpm_event_max_requests_per_child')

  $ulimit_max_files                   = module_param('ulimit_max_files')
  $restricted_files                   = module_param('restricted_files')

  $default_type                       = module_param('default_type')

  $hostname_lookups                   = module_param('hostname_lookups')

  $log_level                          = module_param('log_level')
  $log_formats                        = module_hash('log_formats')

  #---

  $vhost_template                     = module_param('vhost_template')
  $vhost_proxy_template               = module_param('vhost_proxy_template')
  $vhost_redirect_template            = module_param('vhost_redirect_template')

  $server_name                        = module_param('server_name')
  $aliases                            = module_param('aliases')
  $admin_email                        = module_param('admin_email')

  $doc_root                           = module_param('doc_root')
  $proxy_url                          = module_param('proxy_url')
  $destination                        = module_param('destination')

  $configure_firewall                 = module_param('configure_firewall')

  $http_port                          = module_param('http_port')

  $use_ssl                            = module_param('use_ssl')
  $ssl_compression                    = module_param('ssl_compression')
  $ssl_honor_cipher_order             = module_param('ssl_honor_cipher_order')
  $ssl_cert                           = module_param('ssl_cert')
  $ssl_key                            = module_param('ssl_key')
  $ssl_chain                          = module_param('ssl_chain')
  $ssl_protocol                       = module_param('ssl_protocol')
  $ssl_cipher                         = module_param('ssl_cipher')
  $https_port                         = module_param('https_port')

  $priority                           = module_param('priority')
  $options                            = module_param('options')
  $vhost_ip                           = module_param('vhost_ip')

  $error_log_level                    = module_param('error_log_level')
  $rewrite_log_level                  = module_param('rewrite_log_level')
}
