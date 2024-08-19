define tomcat::instance::jaas (
  $tomcat_instance_root_dir,
  $tomcat_instance_number,
  $loginconf=undef
) {

  case $facts['os']['name'] {
    'RedHat', 'CentOS': {
      tomcat::redhat::jaas { $name :
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        loginconf                => $loginconf
      }
    }
    default: { fail("operatingsystem ${facts['os']['name']} is not supported") }
  }

}
