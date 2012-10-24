define tomcat::server::setenv($java_options=undef) {

  case $::operatingsystem {
    redhat, centos: {
      tomcat::redhat::setenv { $name:
        instance     => false,
        java_options => $java_options
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
