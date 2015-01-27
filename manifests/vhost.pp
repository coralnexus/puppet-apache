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

  $server_name         = $name,
  $aliases             = $apache::params::aliases,
  $admin_email         = $apache::params::admin_email,
  $doc_root            = $apache::params::doc_root ? {
    ''                  => "${apache::params::web_home}/${name}",
    default             => $apache::params::doc_root,
  },
  $conf_dir            = $apache::params::conf_dir,
  $vhost_dir           = $apache::params::vhost_dir,
  $configure_firewall  = $apache::params::configure_firewall,
  $port_template       = $apache::params::port_template,
  $vhost_template      = $apache::params::vhost_template,
  $vhost_ip            = $apache::params::vhost_ip,
  $priority            = $apache::params::priority,
  $options             = $apache::params::options,
  $port                = $apache::params::http_port,
  $use_ssl             = $apache::params::use_ssl,
  $ssl_cert_dir        = $apache::params::ssl_cert_dir,
  $ssl_cert            = $apache::params::ssl_cert,
  $ssl_chain           = $apache::params::ssl_chain,
  $ssl_key_dir         = $apache::params::ssl_key_dir,
  $ssl_key             = $apache::params::ssl_key,
  $ssl_group           = $apache::params::ssl_group,
  $ssl_protocol        = $apache::params::ssl_protocol,
  $ssl_cipher          = $apache::params::ssl_cipher,
  $log_dir             = $apache::params::log_dir,
  $error_log_level     = $apache::params::error_log_level,
  $rewrite_log_level   = $apache::params::rewrite_log_level,
  $extra               = {}

) {

  $ssl_cert_file       = "${ssl_cert_dir}/${name}.crt"
  $ssl_chain_file      = "${ssl_cert_dir}/${name}.chain.pem"
  $ssl_key_file        = "${ssl_key_dir}/${name}.key"

  include apache

  if $use_ssl and ! defined(Apache::Module['ssl']) {
    apache::module { 'ssl': }
  }

  #-----------------------------------------------------------------------------

  if $ssl_cert {
    file { "${name}-ssl-cert" :
      path    => $ssl_cert_file,
      content => $ssl_cert,
      mode    => 0644,
      require => Apache::Module['ssl'],
    }
  }
  if $ssl_chain {
    file { "${name}-ssl-chain" :
      path    => $ssl_chain_file,
      content => $ssl_chain,
      mode    => 0644,
      require => Apache::Module['ssl'],
    }
  }

  if $ssl_key {
    file { "${name}-ssl-key" :
      path    => $ssl_key_file,
      content => $ssl_key,
      mode    => 0640,
      group   => $ssl_group,
      require => Apache::Module['ssl'],
    }
  }

  #---

  if $port {
    file { "${vhost_dir}/${name}.conf":
      content => template($vhost_template),
      require => File['apache_vhost_dir'],
      notify  => Service['apache'],
    }

    a2site { "${name}.conf":
      ensure  => 'present',
      require => File["${vhost_dir}/${name}.conf"],
    }

    $port_config_file = "${conf_dir}/ports.${port}.conf"

    if ! defined(File[$port_config_file]) {
      file { $port_config_file:
        content => template($port_template),
        require => File['apache_conf_dir'],
        notify  => Service['apache'],
      }
    }

    if $configure_firewall {
      $firewall_description = "0500 INPUT Accept Apache connection: $port"

      if ! defined(Firewall[$firewall_description]) {
        firewall {$firewall_description:
            action    => 'accept',
            dport     => $port,
            proto     => 'tcp',
            subscribe => File[$port_config_file],
        }
      }
    }
  }
}
