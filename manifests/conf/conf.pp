class tomcat::conf::conf {

  include tomcat

  file { '/opt/tomcat/conf/tomcat-users.xml':
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0644',
    require => Class['tomcat']
  }

}
