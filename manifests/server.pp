define tomcat::server(
  $tomcat_version=undef,
  $versionlock=false
) {

  case $::operatingsystem {
      redhat, centos: {
        tomcat::redhat::server { $name:
          tomcat_version => $tomcat_version,
          versionlock    => $versionlock
        }
      }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
