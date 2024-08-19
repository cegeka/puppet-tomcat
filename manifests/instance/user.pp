define tomcat::instance::user($tomcat_instance_root_dir, $tomcat_instance_number, $username=undef, $password=undef, $roles=undef, $ensure = present) {

  case $facts['os']['name'] {
    'RedHat','CentOS': {
      tomcat::redhat::user { $name:
        ensure                   => $ensure,
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        username                 => $username,
        password                 => $password,
        roles                    => $roles
      }
    }
    default: { fail("operatingsystem ${facts['os']['name']} is not supported") }
  }

}
