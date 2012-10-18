class tomcat::redhat::server($tomcat_version) {

  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)$','\1')

  package { "cegeka-tomcat$tomcat_major_version":
    ensure => $tomcat_version,
  }

  service { "tomcat$tomcat_major_version":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package["cegeka-tomcat$tomcat_major_version"],
  }

}
