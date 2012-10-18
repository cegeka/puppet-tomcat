class tomcat::redhat::server($tomcat_version) {

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
