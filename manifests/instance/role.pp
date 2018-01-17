define tomcat::instance::role($tomcat_instance_root_dir, $tomcat_instance_number, $rolename, $ensure = present) {

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      tomcat::redhat::role { $name:
        ensure                   => $ensure,
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        rolename                 => $rolename
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
