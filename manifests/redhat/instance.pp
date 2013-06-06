define tomcat::redhat::instance(
    $tomcat_instance_root_dir,
    $tomcat_instance_number,
    $tomcat_instance_uid,
    $tomcat_instance_gid,
    $tomcat_instance_password,
    $tomcat_version,
    $tomcat_options=undef,
    $tomcat_listen_address="0.0.0.0",
    $tomcat_jmx_enabled=false,
    $tomcat_jmx_port=undef,
    $tomcat_jmx_serverport=undef
  ) {

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)-(\d+)$','\1')
  $tomcat_version_withoutrelease = regsubst($tomcat_version, '^(\d+\.\d+\.\d+)-.*$','\1')
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"
  $tomcat_installation_dir = "/opt/tomcat-${tomcat_version_withoutrelease}"

  debug("tomcat_instance_name= ${tomcat_instance_name}")
  debug("real_tomcat_instance_dir = ${real_tomcat_instance_dir}")
  notice("tomcat_version_withoutrelease = ${tomcat_version_withoutrelease}")

  include users

  users::localgroup { $tomcat_instance_name:
    gid => $tomcat_instance_gid,
  }

  users::localuser { $tomcat_instance_name:
    uid        => $tomcat_instance_uid,
    logingroup => $tomcat_instance_name,
    home       => $real_tomcat_instance_dir,
    comment    => "Tomcat Instance user $tomcat_instance_name",
    password   => $tomcat_instance_password,
  }

  File {
    owner => $tomcat_instance_name,
    group => $tomcat_instance_name
  }

  file { [ "$real_tomcat_instance_dir/hosts", "$real_tomcat_instance_dir/hosts/localhost", "$real_tomcat_instance_dir/hosts/localhost/webapps"]:
    ensure => directory,
    mode   => '0750'
  }

  file { [ "$real_tomcat_instance_dir/logs", "$real_tomcat_instance_dir/logs/webapps"]:
    ensure => directory,
    mode   => '0750'
  }

  file { [ "$real_tomcat_instance_dir/temp", "$real_tomcat_instance_dir/work"]:
    ensure => directory,
    mode   => '0750'
  }

  file { [ "$real_tomcat_instance_dir/conf", "$real_tomcat_instance_dir/conf/Catalina", "$real_tomcat_instance_dir/conf/Catalina/localhost" ]:
    ensure => directory,
    mode   => '0750'
  }

  file { "$real_tomcat_instance_dir/conf/Catalina/localhost/host-manager.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/Catalina/localhost/host-manager.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf/Catalina/localhost"]
  }

  file { "$real_tomcat_instance_dir/conf/Catalina/localhost/manager.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/Catalina/localhost/manager.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf/Catalina/localhost"]
  }

  file { "$real_tomcat_instance_dir/conf/catalina.policy":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/catalina.policy",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/catalina.properties":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/catalina.properties",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/context.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/context.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/logging.properties":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/logging.properties",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/server.xml":
    ensure  => file,
    content => template("${module_name}/tomcat${tomcat_major_version}/conf/server.xml.erb"),
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/tomcat-users.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/tomcat-users.xml",
    mode    => '0644',
    replace => false,
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/web.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/web.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/bin/catalina.sh":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/bin/catalina.sh",
    mode    => '0644',
    require => Users::Localuser[$tomcat_instance_name]
  }

  if $tomcat_major_version == '7' {
    file { "$real_tomcat_instance_dir/bin/tomcat-juli.jar":
      ensure  => file,
      source  => "puppet:///modules/${module_name}/tomcat${tomcat_major_version}/bin/tomcat-juli.jar",
      mode    => '0644',
      require => Users::Localuser[$tomcat_instance_name]
    }
  }

  file { "/etc/init.d/${tomcat_instance_name}":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/${module_name}/etc/init.d/tomcat"
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
    require    => Package["cegeka-tomcat${tomcat_major_version}"],
  }

  file { "${real_tomcat_instance_dir}/conf/customconfig.sh":
    ensure  => file,
    mode    => '0754',
    replace => false,
    require => File["$real_tomcat_instance_dir/conf"]
  }

  if $tomcat_options {
    file { "${real_tomcat_instance_dir}/conf/config.sh":
      ensure  => file,
      content => template("${module_name}/conf/config.sh.erb"),
      mode    => '0754',
      notify  => Service[$tomcat_instance_name],
      require => File["$real_tomcat_instance_dir/conf"]
    }
  }
}
