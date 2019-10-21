define tomcat::redhat::instance(
    $tomcat_instance_root_dir,
    $tomcat_instance_number,
    $tomcat_instance_uid,
    $tomcat_instance_gid,
    $tomcat_instance_password,
    $tomcat_version,
    $tomcat_options_start,
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
    $tomcat_ssl_connector_enabled=false,
    $tomcat_ssl_keystore_file=undef,
    $tomcat_ssl_keystore_password=undef,
    $tomcat_use_umask=false,
    $tomcat_umask='0002',
    $java_home='/usr/java/latest'
  ) {

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)-(\d+).*','\1')
  $tomcat_version_withoutrelease = regsubst($tomcat_version, '^(\d+\.\d+\.\d+)-.*$','\1')
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"
  $tomcat_installation_dir = "/opt/tomcat-${tomcat_version_withoutrelease}"

  include users

  users::localgroup { $tomcat_instance_name:
    gid => $tomcat_instance_gid,
  }

  users::localuser { $tomcat_instance_name:
    uid        => $tomcat_instance_uid,
    logingroup => $tomcat_instance_name,
    groups     => $tomcat_instance_groups,
    home       => $real_tomcat_instance_dir,
    comment    => "Tomcat Instance user ${tomcat_instance_name}",
    password   => $tomcat_instance_password,
  }

  File {
    owner => $tomcat_instance_name,
    group => $tomcat_instance_name
  }

  file { [ "${real_tomcat_instance_dir}/hosts", "${real_tomcat_instance_dir}/hosts/localhost", "${real_tomcat_instance_dir}/hosts/localhost/webapps"]:
    ensure => directory,
    mode   => '0750'
  }

  file { [ "${real_tomcat_instance_dir}/logs", "${real_tomcat_instance_dir}/logs/webapps"]:
    ensure => directory,
    mode   => '0750'
  }

  file { [ "${real_tomcat_instance_dir}/temp", "${real_tomcat_instance_dir}/work"]:
    ensure => directory,
    mode   => '0750'
  }

  file { [ "${real_tomcat_instance_dir}/conf", "${real_tomcat_instance_dir}/conf/Catalina", "${real_tomcat_instance_dir}/conf/Catalina/localhost" ]:
    ensure => directory,
    mode   => '0750'
  }

  file { "${real_tomcat_instance_dir}/conf/Catalina/localhost/host-manager.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/tomcat${tomcat_major_version}/conf/Catalina/localhost/host-manager.xml",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf/Catalina/localhost"]
  }

  file { "${real_tomcat_instance_dir}/conf/Catalina/localhost/manager.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/tomcat${tomcat_major_version}/conf/Catalina/localhost/manager.xml",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf/Catalina/localhost"]
  }

  file { "${real_tomcat_instance_dir}/conf/catalina.policy":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/catalina.policy",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf"]
  }

  file { "${real_tomcat_instance_dir}/conf/catalina.properties":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/catalina.properties",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf"]
  }

  file { "${real_tomcat_instance_dir}/conf/context.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/context.xml",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf"],
    replace => false,
  }

  file { "${real_tomcat_instance_dir}/conf/logging.properties":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/logging.properties",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf"]
  }

  file { "${real_tomcat_instance_dir}/conf/server.xml":
    ensure  => file,
    content => template("${module_name}/tomcat${tomcat_major_version}/conf/server.xml.erb"),
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf"],
    notify  => Service[$tomcat_instance_name]
  }

  file { "${real_tomcat_instance_dir}/conf/tomcat-users.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/tomcat-users.xml",
    mode    => '0644',
    replace => false,
    require => File["${real_tomcat_instance_dir}/conf"]
  }

  file { "${real_tomcat_instance_dir}/conf/web.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/web.xml",
    mode    => '0644',
    require => File["${real_tomcat_instance_dir}/conf"]
  }

  file { "${real_tomcat_instance_dir}/bin/catalina.sh":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/bin/catalina.sh",
    mode    => '0644',
    require => Users::Localuser[$tomcat_instance_name]
  }

  case $tomcat_major_version {
    '7','8': {
      file { "${real_tomcat_instance_dir}/bin/tomcat-juli.jar":
        ensure  => file,
        source  => "puppet:///modules/${module_name}/tomcat${tomcat_major_version}/bin/tomcat-juli.jar",
        mode    => '0644',
        require => Users::Localuser[$tomcat_instance_name]
      }
    }
  }

  file { "/etc/init.d/${tomcat_instance_name}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/etc/init.d/tomcat.erb"),
  }

  file { "/etc/sysconfig/${tomcat_instance_name}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/etc/sysconfig/tomcat.erb"),
    notify  => Service[$tomcat_instance_name]
  }

  service { $tomcat_instance_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => $tomcat_major_version ? {
      '6'  => [ Package["cegeka-tomcat${tomcat_major_version}"],
                    File["/etc/init.d/${tomcat_instance_name}"],
                    File["/etc/sysconfig/${tomcat_instance_name}"],
                    File["${real_tomcat_instance_dir}/bin/catalina.sh"],
                    File["${real_tomcat_instance_dir}/conf/config-start.sh"],
                    File["${real_tomcat_instance_dir}/conf/config-stop.sh"],
                    File["${real_tomcat_instance_dir}/conf/customconfig.sh"] ],
      '7'  => [ Package["cegeka-tomcat${tomcat_major_version}"],
                    File["/etc/init.d/${tomcat_instance_name}"],
                    File["/etc/sysconfig/${tomcat_instance_name}"],
                    File["${real_tomcat_instance_dir}/bin/catalina.sh"],
                    File["${real_tomcat_instance_dir}/bin/tomcat-juli.jar"],
                    File["${real_tomcat_instance_dir}/conf/config-start.sh"],
                    File["${real_tomcat_instance_dir}/conf/config-stop.sh"],
                    File["${real_tomcat_instance_dir}/conf/customconfig.sh"] ],
      '8'  => [ Package["cegeka-tomcat${tomcat_major_version}"],
                    File["/etc/init.d/${tomcat_instance_name}"],
                    File["/etc/sysconfig/${tomcat_instance_name}"],
                    File["${real_tomcat_instance_dir}/bin/catalina.sh"],
                    File["${real_tomcat_instance_dir}/bin/tomcat-juli.jar"],
                    File["${real_tomcat_instance_dir}/conf/config-start.sh"],
                    File["${real_tomcat_instance_dir}/conf/config-stop.sh"],
                    File["${real_tomcat_instance_dir}/conf/customconfig.sh"] ]
    }
  }

  file { "${real_tomcat_instance_dir}/conf/config-start.sh":
    ensure  => file,
    content => template("${module_name}/conf/config-start.sh.erb"),
    mode    => '0754',
    notify  => Service[$tomcat_instance_name],
    require => File["${real_tomcat_instance_dir}/conf"]
  }
  file { "${real_tomcat_instance_dir}/conf/config-stop.sh":
    ensure  => file,
    content => template("${module_name}/conf/config-stop.sh.erb"),
    mode    => '0754',
    notify  => Service[$tomcat_instance_name],
    require => File["${real_tomcat_instance_dir}/conf"]
  }

  file { "${real_tomcat_instance_dir}/conf/customconfig.sh":
    ensure  => file,
    mode    => '0754',
    replace => false,
    require => File["${real_tomcat_instance_dir}/conf"]
  }

}
