define tomcat::conf::setenv($java_options=undef) {

  include tomcat

  file { '/opt/tomcat/bin/setenv.sh':
    ensure  => present,
    content => template("${module_name}/bin/setenv.sh.erb"),
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0754',
    require => Class['tomcat'],
  }

}
