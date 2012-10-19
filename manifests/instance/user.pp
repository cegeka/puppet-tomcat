define tomcat::instance::user($tomcat_instance_root_dir, $tomcat_instance_number, $username, $password, $roles, $ensure = present) {

  case $::operatingsystem {
    redhat, centos: {
      tomcat::redhat::user { $name:
        ensure                   => $ensure,
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        username                 => $username,
        password                 => $password,
        roles                    => $roles
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
