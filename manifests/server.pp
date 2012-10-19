define tomcat::server($tomcat_version) {

  case $::operatingsystem {
      redhat, centos: {
        tomcat::redhat::server { $name:
          tomcat_version => $tomcat_version,
        }
      }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
