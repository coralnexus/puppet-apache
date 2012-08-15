
define apache::vhost::file (

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
  $vhost_ip            = $apache::params::vhost_ip,
  $priority            = $apache::params::priority,
  $options             = $apache::params::options,
  $http_port           = $apache::params::http_port,
  $https_port          = $apache::params::https_port,
  $use_ssl             = $apache::params::use_ssl,
  $ssl_cert_dir        = $apache::params::ssl_cert_dir,
  $ssl_cert            = $apache::params::ssl_cert,
  $ssl_key_dir         = $apache::params::ssl_key_dir,
  $ssl_key             = $apache::params::ssl_key,
  $ssl_group           = $apache::params::ssl_group,
  $log_dir             = $apache::params::log_dir,
  $error_log_level     = $apache::params::error_log_level,
  $rewrite_log_level   = $apache::params::rewrite_log_level,
  $port_template       = $apache::params::port_template,
  $vhost_template      = $apache::params::vhost_template,

) {

  #-----------------------------------------------------------------------------

  if $http_port {
    apache::vhost { "${priority}-${name}-http":
      server_name         => $server_name,
      aliases             => $aliases,
      doc_root            => $doc_root,
      conf_dir            => $conf_dir,
      vhost_dir           => $vhost_dir,
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
    apache::vhost { "${priority}-${name}-https":
      server_name         => $server_name,
      aliases             => $aliases,
      doc_root            => $doc_root,
      conf_dir            => $conf_dir,
      vhost_dir           => $vhost_dir,
      configure_firewall  => $configure_firewall,
      vhost_ip            => $vhost_ip,
      priority            => $priority,
      options             => $options,
      port                => $https_port,
      use_ssl             => 'true',
      ssl_cert_dir        => $ssl_cert_dir,
      ssl_cert            => $ssl_cert,
      ssl_key_dir         => $ssl_key_dir,
      ssl_key             => $ssl_key,
      ssl_group           => $ssl_group,
      log_dir             => $log_dir,
      error_log_level     => $error_log_level,
      rewrite_log_level   => $rewrite_log_level,
      admin_email         => $admin_email,
      port_template       => $port_template,
      vhost_template      => $vhost_template,
    }
  }
}
