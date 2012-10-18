define tomcat::instance($tomcat_instance_dir, $tomcat_instance_number, $tomcat_instance_uid, $tomcat_instance_gid) {

  case $::operatingsystem {
      redhat, centos: { include tomcat::redhat::instance }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
