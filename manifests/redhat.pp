class tomcat::redhat {

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
