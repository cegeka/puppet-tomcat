class tomcat::conf::conf {

  #include tomcat

  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)$','\1')

  file { '/opt/tomcat/conf/tomcat-users.xml':
    ensure  => file,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0644',
    require => Package["cegeka-tomcat${tomcat_major_version}"],
    notify  => Service["tomcat${tomcat_major_version}"]
  }

}
