define tomcat::server::setenv(
  $tomcat_instance_root_dir,
  $tomcat_instance_number,
  $java_options=undef,
  $ensure=present,
) {

  case $::operatingsystem {
    redhat, centos: {
      tomcat::redhat::setenv { $name:
        ensure                    => $ensure,
        tomcat_instance_root_dir  => $tomcat_instance_root_dir,
        tomcat_instance_number    => $tomcat_instance_number,
        java_options              => $java_options,
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
