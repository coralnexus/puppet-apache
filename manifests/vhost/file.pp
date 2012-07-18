
define apache::vhost::file (

  $server_name         = $apache::params::server_name ? {
    ''                  => $name,
    default             => $apache::params::server_name,
  },
  $aliases             = $apache::params::aliases,
  $admin_email         = $apache::params::admin_email,
  $doc_root            = $apache::params::doc_root ? {
    ''                  => "${apache::params::web_home}/${name}",
    default             => $apache::params::doc_root,
  },
  $configure_firewall  = $apache::params::configure_firewall,
  $vhost_ip            = $apache::params::vhost_ip,
  $priority            = $apache::params::priority,
  $options             = $apache::params::options,
  $http_port           = $apache::params::http_port,
  $https_port          = $apache::params::https_port,
  $use_ssl             = $apache::params::use_ssl,
  $ssl_cert            = $apache::params::ssl_cert ? {
    ''                  => "/etc/ssl/certs/${name}.crt",
    default             => $apache::params::ssl_cert,
  },
  $ssl_key             = $apache::params::ssl_key ? {
    ''                  => "/etc/ssl/private/${name}.key",
    default             => $apache::params::ssl_key,
  },
  $log_dir             = $apache::params::os_apache_log_dir,
  $error_log_level     = $apache::params::error_log_level,
  $rewrite_log_level   = $apache::params::rewrite_log_level,
  $extra               = {},
  $port_template       = $apache::params::port_template,
  $vhost_template      = $apache::params::vhost_template,

) {

  #-----------------------------------------------------------------------------

  if $http_port {
    apache::vhost { "${priority}-${server_name}-http":
      server_name         => $server_name,
      aliases             => $aliases,
      doc_root            => $doc_root,
      configure_firewall  => $configure_firewall,
      vhost_ip            => $vhost_ip,
      priority            => $priority,
      options             => $options,
      port                => $http_port,
      use_ssl             => 'false',
      log_dir             => $log_dir,
      error_log_level     => $error_log_level,
      rewrite_log_level   => $rewrite_log_level,
      admin_email         => $admin_email,
      port_template       => $port_template,
      vhost_template      => $vhost_template,
    }
  }

  if $use_ssl == 'true' and $https_port and $ssl_cert and $ssl_key {
    apache::vhost { "${priority}-${server_name}-https":
      server_name         => $server_name,
      aliases             => $aliases,
      doc_root            => $doc_root,
      configure_firewall  => $configure_firewall,
      vhost_ip            => $vhost_ip,
      priority            => $priority,
      options             => $options,
      port                => $https_port,
      use_ssl             => 'true',
      ssl_cert            => $ssl_cert,
      ssl_key             => $ssl_key,
      log_dir             => $log_dir,
      error_log_level     => $error_log_level,
      rewrite_log_level   => $rewrite_log_level,
      admin_email         => $admin_email,
      port_template       => $port_template,
      vhost_template      => $vhost_template,
    }
  }
}
