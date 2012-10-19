define tomcat::redhat::server($tomcat_version) {

  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)$','\1')

  debug("tomcat_major_version=${tomcat_major_version}")
  debug("tomcat_version=${tomcat_version}")

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
