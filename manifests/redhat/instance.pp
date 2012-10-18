class tomcat::redhat::instance($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_instance_uid, $tomcat_instance_gid) {

  $real_tomcat_instance_dir = "${tomcat::tomcat_instance_root_dir}/${tomcat::tomcat_instance_name}"
  $tomcat_instance_name = "tomcat${tomcat::tomcat_instance_number}"

  include users

  users::localgroup { $tomcat_instance_name:
    gid => $tomcat::instance::tomcat_instance_gid,
  }

  users::localuser { $tomcat_instance_name:
    uid        => $tomcat::instance::tomcat_instance_uid,
    logingroup => $tomcat_instance_name,
    home       => $real_tomcat_instance_dir,
    comment    => "Tomcat Instance user $tomcat_instance_name",
    password   => generate('/usr/bin/openssl', 'passwd', '-1', $tomcat_instance_name),
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

}
