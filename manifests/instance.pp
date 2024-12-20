define tomcat::instance(
    $tomcat_instance_root_dir,
    $tomcat_instance_number,
    $tomcat_instance_uid,
    $tomcat_instance_gid,
    $tomcat_instance_password,
    $tomcat_version,
    $tomcat_options_start,
    $tomcat_ajp_secretrequired=true,
    $tomcat_instance_groups=undef,
    $tomcat_options_stop=undef,
    $tomcat_listen_address='0.0.0.0',
    $tomcat_connector_http_max_threads='100',
    $tomcat_jmx_enabled=false,
    $tomcat_jmx_port=undef,
    $tomcat_jmx_serverport=undef,
    $tomcat_access_log_valve_enabled=true,
    $tomcat_access_log_valve_pattern='common',
    $tomcat_remote_ip_valve_enabled=false,
    $tomcat_error_report_valve_enabled=false,
    $tomcat_ssl_connector_enabled=false,
    $tomcat_ssl_keystore_file=undef,
    $tomcat_ssl_keystore_password=undef,
    $java_home='/usr/java/latest',
    $tomcat_gzip_compression_enabled=false,
    $tomcat_gzip_compression_min_size='2048',
    $tomcat_use_umask=false,
    $tomcat_umask='0002',
    $tomcat_service_file_managed=true
  ) {

  if $tomcat_instance_number !~ /^[0-9]+$/ {
    fail("Tomcat::Instance[${title}]: parameter tomcat_instance_number must be numeric")
  }

  case $facts['os']['name'] {
    'RedHat', 'CentOS': {
      tomcat::redhat::instance { $name:
        tomcat_instance_root_dir          => $tomcat_instance_root_dir,
        tomcat_instance_number            => $tomcat_instance_number,
        tomcat_instance_uid               => $tomcat_instance_uid,
        tomcat_instance_gid               => $tomcat_instance_gid,
        tomcat_instance_groups            => $tomcat_instance_groups,
        tomcat_instance_password          => $tomcat_instance_password,
        tomcat_ajp_secretrequired         => $tomcat_ajp_secretrequired,
        tomcat_version                    => $tomcat_version,
        tomcat_options_start              => $tomcat_options_start,
        tomcat_options_stop               => $tomcat_options_stop,
        tomcat_listen_address             => $tomcat_listen_address,
        tomcat_connector_http_max_threads => $tomcat_connector_http_max_threads,
        tomcat_jmx_enabled                => $tomcat_jmx_enabled,
        tomcat_jmx_port                   => $tomcat_jmx_port,
        tomcat_jmx_serverport             => $tomcat_jmx_serverport,
        tomcat_access_log_valve_enabled   => $tomcat_access_log_valve_enabled,
        tomcat_access_log_valve_pattern   => $tomcat_access_log_valve_pattern,
        tomcat_remote_ip_valve_enabled    => $tomcat_remote_ip_valve_enabled,
        tomcat_error_report_valve_enabled => $tomcat_error_report_valve_enabled,
        tomcat_ssl_connector_enabled      => $tomcat_ssl_connector_enabled,
        tomcat_ssl_keystore_file          => $tomcat_ssl_keystore_file,
        tomcat_ssl_keystore_password      => $tomcat_ssl_keystore_password,
        tomcat_gzip_compression_enabled   => $tomcat_gzip_compression_enabled,
        tomcat_gzip_compression_min_size  => $tomcat_gzip_compression_min_size,
        java_home                         => $java_home,
        tomcat_use_umask                  => $tomcat_use_umask,
        tomcat_umask                      => $tomcat_umask,
        tomcat_service_file_managed       => $tomcat_service_file_managed
      }
    }
    default: { fail("operatingsystem ${facts['os']['name']} is not supported") }
  }

}
