define tomcat::instance::jmx_monitoring($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_jmx_username, $tomcat_jmx_password) {

  case $::operatingsystem {
    redhat, centos: {
      tomcat::redhat::jmx_monitoring { $name:
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        tomcat_jmx_username      => $tomcat_jmx_username,
        tomcat_jmx_password      => $tomcat_jmx_password
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
