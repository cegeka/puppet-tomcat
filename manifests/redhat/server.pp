class tomcat::redhat::server($tomcat_version) {

  #regex for getting first part...
  $major_version = ''

  package { "cegeka-tomcat$tomcat_version":
    ensure => present,
  }

  service { "tomcat$tomcat_version":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package["cegeka-tomcat$tomcat_version"],
  }

}
