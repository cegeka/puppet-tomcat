define tomcat::redhat::server() {

  package { 'tomcat':
    ensure => present,
  }

  service { 'tomcat':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['tomcat'],
  }

}
