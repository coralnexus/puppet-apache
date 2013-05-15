
define apache::vhost::redirect (

  $server_name         = $name,
  $aliases             = $apache::params::aliases,
  $admin_email         = $apache::params::admin_email,
  $destination         = $apache::params::destination,
  $conf_dir            = $apache::params::conf_dir,
  $vhost_dir           = $apache::params::vhost_dir,
  $configure_firewall  = $apache::params::configure_firewall,
  $vhost_ip            = $apache::params::vhost_ip,
  $priority            = $apache::params::priority,
  $options             = $apache::params::options,
  $port                = $apache::params::http_port,
  $log_dir             = $apache::params::log_dir,
  $error_log_level     = $apache::params::error_log_level,
  $port_template       = $apache::params::port_template,
  $vhost_template      = $apache::params::vhost_redirect_template,

) {

  #-----------------------------------------------------------------------------

  apache::vhost { "${priority}-${name}-redirect":
    server_name         => $server_name,
    aliases             => $aliases,
    doc_root            => undef,
    conf_dir            => $conf_dir,
    vhost_dir           => $vhost_dir,
    configure_firewall  => $configure_firewall,
    vhost_ip            => $vhost_ip,
    priority            => $priority,
    options             => $options,
    port                => $port,
    use_ssl             => false,
    log_dir             => $log_dir,
    error_log_level     => $error_log_level,
    admin_email         => $admin_email,
    extra               => {
      'destination'       => $destination,
    },
    port_template       => $port_template,
    vhost_template      => $vhost_template,
  }
}
