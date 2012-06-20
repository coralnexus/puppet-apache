# Definition: apache::vhost
#
# This class installs Apache Virtual Hosts
#
# Parameters:
# - The $port to configure the host on
# - The $docroot provides the DocumentationRoot variable
# - The $ssl option is set true or false to enable SSL for this Virtual Host
# - The $configure_firewall option is set to true or false to specify if
#   a firewall should be configured.
# - The $template option specifies whether to use the default template or
#   override
# - The $priority of the site
# - The $serveraliases of the site
# - The $options for the given vhost
# - The $vhost_name for name based virtualhosting, defaulting to *
#
# Actions:
# - Install Apache Virtual Hosts
#
# Requires:
# - The apache class
#
# Sample Usage:
#  apache::vhost { 'site.name.fqdn':
#    priority => '20',
#    port => '80',
#    docroot => '/path/to/docroot',
#  }
#
define apache::vhost (

  $server_name        = $name,
  $aliases            = '',
  $doc_root           = "${apache::params::web_home}/${name}",
  $configure_firewall = true,
  $vhost_ip           = $apache::params::vhost_ip,
  $priority           = $apache::params::priority,
  $options            = $apache::params::options,
  $http_port          = $apache::params::http_port,
  $use_ssl            = $apache::params::use_ssl,
  $ssl_cert           = "/etc/ssl/certs/${name}.crt",
  $ssl_key            = "/etc/ssl/private/${name}.key",
  $https_port         = $apache::params::https_port,
  $log_dir            = $apache::params::apache_log_dir,
  $error_log_level    = undef,
  $rewrite_log_level  = undef,
  $admin_email        = undef,
  $http_template      = $apache::params::http_template,
  $https_template     = $apache::params::https_template,

) {

  include apache

  if $http_port {
    file { "${priority}-${server_name}.http.conf":
      path    => "${apache::params::apache_vdir}/${priority}-${server_name}.http.conf",
      content => template($http_template),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['apache'],
      notify  => Service['apache'],
    }

    file { "${priority}-${server_name}-http_port":
      path => "${apache::params::apache_ports_dir}/ports.${http_port}.conf",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('apache/ports.conf.erb'),
      require => Package['apache'],
      notify  => Service['apache'],
    }

    if $configure_firewall {
      if ! defined(Firewall["0500 INPUT Accept Apache connection: $http_port"]) {
        firewall {
          "0500 INPUT Accept Apache connection: $http_port":
            action    => 'accept',
            dport     => $http_port,
            proto     => 'tcp',
            subscribe => File["${priority}-${server_name}-http_port"],
        }
      }
    }
  }

  if $use_ssl and $https_port and $ssl_cert and $ssl_key {
    include apache::ssl

    file { "${priority}-${server_name}.https.conf":
      path    => "${apache::params::apache_vdir}/${priority}-${server_name}.https.conf",
      content => template($https_template),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['apache'],
      notify  => Service['apache'],
    }

    file { "${priority}-${server_name}-https_port":
      path => "${apache::params::apache_ports_dir}/ports.ssl.${https_port}.conf",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('apache/ports.ssl.conf.erb'),
      require => Package['apache'],
      notify  => Service['apache'],
    }

    if $configure_firewall {
      if ! defined(Firewall["0550 INPUT Accept Apache SSL connection: $https_port"]) {
        firewall {
          "0550 INPUT Accept Apache connection: $https_port":
            action    => 'accept',
            dport     => $https_port,
            proto     => 'tcp',
            subscribe => File["${priority}-${server_name}-https_port"],
        }
      }
    }
  }
}

