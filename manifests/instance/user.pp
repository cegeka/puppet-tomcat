define tomcat::instance::user($tomcat_instance_root_dir, $tomcat_instance_number, $username=undef, $password=undef, $roles=undef, $ensure = present) {

  case $::operatingsystem {
    'RedHat,' 'CentOS': {
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
