# Class: apache::params
#
# This class manages Apache parameters
#
# Parameters:
# - The $user that Apache runs as
# - The $group that Apache runs as
# - The $apache_name is the name of the package and service on the relevant
#   distribution
# - The $php_package is the name of the package that provided PHP
# - The $ssl_package is the name of the Apache SSL package
# - The $apache_dev is the name of the Apache development libraries package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class apache::params {

  $user           = 'www-data'
  $group          = 'www-data'

  $http_port      = 80

  $use_ssl        = false
  $https_port     = 443

  $http_template  = 'apache/vhost-http.conf.erb'
  $https_template = 'apache/vhost-https.conf.erb'
  $priority       = '25'

  $options        = 'Indexes FollowSymLinks MultiViews'
  $vhost_ip       = '*'

  $web_home       = '/var/www'

  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific': {
      $apache_name        = 'httpd'
      $php_package        = 'php'
      $mod_python_package = 'mod_python'
      $mod_wsgi_package   = 'mod_wsgi'
      $ssl_package        = 'mod_ssl'
      $apache_dev         = 'httpd-devel'

      $apache_vdir        = '/etc/httpd/conf.d'
      $apache_ports_dir   = $apache_vdir
      $apache_log_dir     = '/var/log/httpd'
    }
    'ubuntu', 'debian': {
      $apache_name        = 'apache2'
      $php_package        = 'libapache2-mod-php5'
      $mod_python_package = 'libapache2-mod-python'
      $mod_wsgi_package   = 'libapache2-mod-wsgi'
      $ssl_package        = 'apache-ssl'
      $apache_dev         = ['libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev']

      $apache_etc         = '/etc/apache2'
      $apache_vdir        = "${apache_etc}/sites-enabled"
      $apache_config      = "${apache_etc}/apache2.conf"
      $apache_ports_dir   = "${apache_etc}/conf.d"
      $apache_vars        = "${apache_etc}/envvars"
      $apache_log_dir     = '/var/log/apache2'
    }
    default: {
      $apache_name        = 'apache2'
      $php_package        = 'libapache2-mod-php5'
      $mod_python_package = 'libapache2-mod-python'
      $mod_wsgi_package   = 'libapache2-mod-wsgi'
      $ssl_package        = 'apache-ssl'
      $apache_dev         = 'apache-dev'

      $apache_etc         = '/etc/apache2'
      $apache_vdir        = "${apache_etc}/sites-enabled"
      $apache_ports_dir   = "${apache_etc}/conf.d"
      $apache_log_dir     = '/var/log/apache2'
    }
  }
}
