define tomcat::instance::role($tomcat_instance_root_dir, $tomcat_instance_number, $rolename, $ensure = present) {

  case $facts['os']['name'] {
    'RedHat', 'CentOS': {
      tomcat::redhat::role { $name:
        ensure                   => $ensure,
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        rolename                 => $rolename
      }
    }
    default: { fail("operatingsystem ${facts['os']['name']} is not supported") }
  }

}
