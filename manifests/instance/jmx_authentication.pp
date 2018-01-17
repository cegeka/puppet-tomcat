define tomcat::instance::jmx_authentication($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_jmx_username, $tomcat_jmx_password, $tomcat_jmx_access) {

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      tomcat::redhat::jmx_authentication { $name:
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        tomcat_jmx_username      => $tomcat_jmx_username,
        tomcat_jmx_password      => $tomcat_jmx_password,
        tomcat_jmx_access        => $tomcat_jmx_access
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
