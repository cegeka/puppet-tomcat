class tomcat::redhat {

  package { 'tomcat':
    ensure => present,
  }

  service { 'tomcat':
    ensure     => present,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['tomcat'],
  }

}
