define tomcat::server::setenv(
  $tomcat_instance_number,
  $tomcat_instance_root_dir,
  $ensure=present,
  $instance=true,
  $java_options=undef,
) {

  case $facts['os']['name'] {
    'RedHat', 'CentOS': {
      tomcat::redhat::setenv { $name :
        ensure                    => $ensure,
        tomcat_instance_root_dir  => $tomcat_instance_root_dir,
        tomcat_instance_number    => $tomcat_instance_number,
        java_options              => $java_options,
        instance                  => $instance,
      }
    }
    default: { fail("operatingsystem ${facts['os']['name']} is not supported") }
  }

}
