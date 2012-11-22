define tomcat:redhat::jmx_monitoring($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_jmx_username, $tomcat_jmx_password, $tomcat_jmx_access) {

  file { "${tomcat_instance_root_dir}/tomcat${tomcat_instance_number}/conf/jmxremote.password":
    ensure  => file,
    content => template("${module_name}/conf/jmxremote.password.erb"),
    owner   => "tomcat${tomcat_instance_number}",
    group   => "tomcat${tomcat_instance_number}",
    mode    => '0600',
  }

  file { "${tomcat_instance_root_dir}/tomcat${tomcat_instance_number}/conf/jmxremote.access":
    ensure  => file,
    content => template("${module_name}/conf/jmxremote.access.erb"),
    owner   => "tomcat${tomcat_instance_number}",
    group   => "tomcat${tomcat_instance_number}",
    mode    => '0600',
  }

}
