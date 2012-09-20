# Class: tomcat
#
# This module manages tomcat
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class tomcat($setenv=undef) {

  case $::operatingsystem {
      redhat, centos: { include tomcat::redhat }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
