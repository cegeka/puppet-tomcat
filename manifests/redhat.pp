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

  file { '/opt/tomcat/bin/setenv.sh':
    ensure  => present,
    content => template("${module_name}/setenv.sh.erb"),
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0754',
    before  => Service['tomcat'],
    require => Package['tomcat'],
  }

  file { '/opt/tomcat/conf/tomcat-users.xml':
    ensure  => present,
    content => template("${module_name}/tomcat-users.xml.erb"),
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0644',
    before  => Service['tomcat'],
    require => Package['tomcat'],
  }

}
