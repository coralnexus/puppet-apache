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

  $server_name         = $name,
  $aliases             = '',
  $doc_root            = "${apache::params::web_home}/${name}",
  $configure_firewall  = true,
  $vhost_ip            = $apache::params::vhost_ip,
  $priority            = $apache::params::priority,
  $options             = $apache::params::options,
  $port                = $apache::params::default_port,
  $use_ssl             = $apache::params::use_ssl,
  $ssl_cert            = "/etc/ssl/certs/${name}.crt",
  $ssl_key             = "/etc/ssl/private/${name}.key",
  $log_dir             = $apache::params::os_apache_log_dir,
  $error_log_level     = undef,
  $rewrite_log_level   = undef,
  $admin_email         = undef,
  $extra               = {},
  $port_template       = $apache::params::port_template,
  $vhost_template      = $apache::params::vhost_template,

) {

  include apache

  if $use_ssl {
    include apache::mod::ssl
  }

  #-----------------------------------------------------------------------------

  if $port {
    file { "${apache::params::os_apache_vhost_dir}/${server_name}.conf":
      content => template($vhost_template),
      require => File['apache_vhost_dir'],
      notify  => Service['apache'],
    }

    $port_config_file = "${apache::params::os_apache_conf_dir}/ports.${port}.conf"

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
