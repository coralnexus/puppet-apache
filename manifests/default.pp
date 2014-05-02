
class apache::default {

  $package_ensure                     = 'present'
  $service_ensure                     = 'running'
  $use_dev                            = false
  $dev_ensure                         = 'present'
  $conf_ensure                        = 'present'
  $module_ensure                      = 'present'
  $module_lib_ensure                  = 'present'
  $modules                            = []

  $user                               = 'www-data'
  $group                              = 'www-data'
  $locale                             = ''

  $log_mode                           = '0770'

  $web_home                           = '/var/www'
  $web_home_mode                      = '0755'

  $access_file                        = '.htaccess'

  $timeout                            = 300
  $keepalive                          = true
  $max_keepalive_requests             = 100
  $keepalive_timeout                  = 5

  $mpm_prefork_start_servers          = 5
  $mpm_prefork_min_spare_servers      = 5
  $mpm_prefork_max_spare_servers      = 10
  $mpm_prefork_max_clients            = 150
  $mpm_prefork_max_requests_per_child = 0

  $mpm_worker_start_servers           = 2
  $mpm_worker_min_spare_threads       = 25
  $mpm_worker_max_spare_threads       = 75
  $mpm_worker_thread_limit            = 64
  $mpm_worker_threads_per_child       = 25
  $mpm_worker_max_clients             = 150
  $mpm_worker_max_requests_per_child  = 0

  $mpm_event_start_servers            = 2
  $mpm_event_min_spare_threads        = 25
  $mpm_event_max_spare_threads        = 75
  $mpm_event_thread_limit             = 64
  $mpm_event_threads_per_child        = 25
  $mpm_event_max_clients              = 150
  $mpm_event_max_requests_per_child   = 0

  $ulimit_max_files                   = 8192
  $restricted_files                   = [ '^\.ht' ]

  $default_type                       = 'None'

  $hostname_lookups                   = false

  $log_level                          = 'warn'
  $log_formats                        = {
    "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" => 'vhost_combined',
    "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\""       => 'combined',
    "%h %l %u %t \"%r\" %>s %O"                                          => 'common',
    "%{Referer}i -> %U"                                                  => 'referer',
    "%{User-agent}i"                                                     => 'agent',
  }

  $server_name                        = ''
  $aliases                            = ''
  $admin_email                        = ''
  $doc_root                           = ''
  $proxy_url                          = '*'
  $destination                        = ''
  $configure_firewall                 = true
  $vhost_ip                           = '*'
  $http_port                          = 80
  $use_ssl                            = false
  $ssl_cert                           = ''
  $ssl_key                            = ''
  $https_port                         = 443
  $priority                           = 25
  $options                            = 'Indexes FollowSymLinks MultiViews'
  $error_log_level                    = ''
  $rewrite_log_level                  = ''

  #---

  case $::operatingsystem {
    centos, redhat, fedora, scientific: {
      $package                 = 'httpd'
      $dev_package             = 'httpd-devel'

      $mod_php_package         = 'php'
      $mod_python_package      = 'mod_python'
      $mod_wsgi_package        = 'mod_wsgi'

      $vhost_dir               = '/etc/httpd/conf.d'
      $conf_dir                = $vhost_dir
      $log_dir                 = '/var/log/httpd'
      $run_dir                 = '/var/run/httpd'
      $lock_dir                = '/var/lock/httpd'

      fail("The apache module currently needs some configuration work for ${::operatingsystem}")
    }
    ubuntu, debian: {
      $package                 = 'apache2'
      $service                 = 'apache2'
      $dev_packages            = ['libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev']

      $mod_php_package         = 'libapache2-mod-php5'
      $mod_python_package      = 'libapache2-mod-python'
      $mod_wsgi_package        = 'libapache2-mod-wsgi'

      $config_dir              = '/etc/apache2'
      $config_file             = "${config_dir}/apache2.conf"
      $vhost_dir               = "${config_dir}/sites-available"
      $vhost_enable_dir        = "${config_dir}/sites-enabled"
      $conf_dir                = "${config_dir}/conf.d"
      $vars_file               = "${config_dir}/envvars"
      $log_dir                 = '/var/log/apache2'
      $run_dir                 = '/var/run/apache2'
      $lock_dir                = '/var/lock/apache2'

      $ssl_cert_dir            = '/etc/ssl/certs'
      $ssl_key_dir             = '/etc/ssl/private'
      $ssl_group               = 'ssl-cert'

      $config_template         = 'apache/debian.apache2.conf.erb'
      $vars_template           = 'apache/debian.envvars.erb'
      $port_template           = 'apache/ports.conf.erb'
      $vhost_template          = 'apache/vhost.conf.erb'
      $vhost_proxy_template    = 'apache/vhost-proxy.conf.erb'
      $vhost_redirect_template = 'apache/vhost-redirect.conf.erb'

      $default_vhost_names     = [ '000-default.conf' ]
    }
    default: {
      fail("The apache module is not currently supported on ${::operatingsystem}")
    }
  }
}
