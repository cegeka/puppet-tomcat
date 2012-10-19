define tomcat::redhat::jaas($tomcat_instance_root_dir, $tomcat_instance_number, $loginconf=undef) {

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"

  if ($loginconf == undef) {
    fail("Tomcat::Conf::Jaas[${title}]: parameter loginconf must be defined")
  }

  file { "${real_tomcat_instance_dir}/conf/login.conf":
    ensure  => file,
    content => $loginconf,
    owner   => $tomcat_instance_name,
    group   => $tomcat_instance_name,
    mode    => '0644',
    notify  => Service[$tomcat_instance_name]
  }

}
