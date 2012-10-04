define tomcat::conf::jaas($loginconf=undef) {

  include tomcat

  if ($loginconf == undef) {
    fail("Tomcat::Conf::Jaas[${title}]: parameter loginconf must be defined")
  }

  $auth_login_conf = '/opt/tomcat/conf/login.conf'

  file { $auth_login_conf:
    ensure  => file,
    content => $loginconf,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0644',
    require => Class['tomcat'],
  }

}
