define tomcat::server($tomcat_version) {

  include tomcat

  case $::operatingsystem {
      redhat, centos: {
        class { 'tomcat::redhat::server':
          tomcat_version => $tomcat_version,
        }
      }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
