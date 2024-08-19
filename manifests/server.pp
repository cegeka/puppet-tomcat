define tomcat::server(
  $tomcat_version=undef,
  $versionlock=false
) {

  case $facts['os']['name'] {
      'RedHat', 'CentOS': {
        tomcat::redhat::server { $name:
          tomcat_version => $tomcat_version,
          versionlock    => $versionlock
        }
      }
      default: { fail("operatingsystem ${facts['os']['name']} is not supported") }
  }

}
