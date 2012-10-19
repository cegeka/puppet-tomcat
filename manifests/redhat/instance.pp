define tomcat::redhat::instance($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_instance_uid, $tomcat_instance_gid, $tomcat_instance_password) {

  $tomcat_installation_dir = "/opt/apache-tomcat-${tomcat_version}"

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"

  debug("tomcat_instance_name= ${tomcat_instance_name}")
  debug("real_tomcat_instance_dir = ${real_tomcat_instance_dir}")

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

  file { [ "$real_tomcat_instance_dir/hosts", "$real_tomcat_instance_dir/hosts/localhost", "$real_tomcat_instance_dir/hosts/localhost/webapps"]:
    ensure => directory,
    owner  => $tomcat_instance_name,
    group  => $tomcat_instance_name,
    mode   => '0750'
  }

  file { [ "$real_tomcat_instance_dir/logs", "$real_tomcat_instance_dir/logs/webapps"]:
    ensure => directory,
    owner  => $tomcat_instance_name,
    group  => $tomcat_instance_name,
    mode   => '0750'
  }

  file { [ "$real_tomcat_instance_dir/temp", "$real_tomcat_instance_dir/work"]:
    ensure => directory,
    owner  => $tomcat_instance_name,
    group  => $tomcat_instance_name,
    mode   => '0750'
  }

  file { [ "$real_tomcat_instance_dir/conf", "$real_tomcat_instance_dir/conf/Catalina", "$real_tomcat_instance_dir/conf/Catalina/localhost" ]:
    ensure => directory,
    owner  => $tomcat_instance_name,
    group  => $tomcat_instance_name,
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
    source  => "puppet:///modules/${module_name}/instance/conf/server.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/tomcat-users.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/tomcat-users.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "$real_tomcat_instance_dir/conf/web.xml":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/instance/conf/web.xml",
    mode    => '0644',
    require => File["$real_tomcat_instance_dir/conf"]
  }

  file { "/etc/init.d/${tomcat_instance_name}":
    ensure  => file,
    source  => "puppet:///modules/${module_name}/etc/init.d/tomcat",
    mode    => '0755',
    owner   => 'root',
    group   => 'root'
  }

  file { "/etc/sysconfig/${tomcat_instance_name}":
    ensure  => file,
    content => template("${module_name}/etc/sysconfig/tomcat.erb"),
    mode    => '0755',
    owner   => 'root',
    group   => 'root'
  }

}
