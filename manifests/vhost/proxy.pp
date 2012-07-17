
define apache::vhost::proxy (

  $server_name         = $apache::params::server_name ? {
    ''                  => $name,
    default             => $apache::params::server_name,
  },
  $aliases             = $apache::params::aliases,
  $admin_email         = $apache::params::admin_email,
  $proxy_url           = $apache::params::proxy_url,
  $destination         = $apache::params::destination,
  $configure_firewall  = $apache::params::configure_firewall,
  $vhost_ip            = $apache::params::vhost_ip,
  $priority            = $apache::params::priority,
  $options             = $apache::params::options,
  $port                = $apache::params::default_port,
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
  $port_template       = $apache::params::port_template,
  $vhost_template      = $apache::params::vhost_proxy_template,

) {

  #-----------------------------------------------------------------------------

  apache::vhost { "${priority}-${server_name}-proxy":
    server_name         => $server_name,
    aliases             => $aliases,
    doc_root            => undef,
    configure_firewall  => $configure_firewall,
    vhost_ip            => $vhost_ip,
    priority            => $priority,
    options             => $options,
    port                => $port,
    use_ssl             => $use_ssl,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    log_dir             => $log_dir,
    error_log_level     => $error_log_level,
    rewrite_log_level   => $rewrite_log_level,
    admin_email         => $admin_email,
    extra               => {
      'proxy_url'         => $proxy_url,
      'destination'       => $destination,
    },
    port_template       => $port_template,
    vhost_template      => $vhost_template,
  }
}
