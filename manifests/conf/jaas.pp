define tomcat::conf::jaas($loginconf=undef, $java_options=undef) {

  include tomcat

  if ($loginconf == undef) {
    fail("Tomcat::Conf::Jaas[${title}]: parameter loginconf must be defined")
  }
  if ($java_options == undef) {
    fail("Tomcat::Conf::Jaas[${title}]: parameter java_options must be defined")
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

  #call generic define for setting jvm option -Djava.security.auth.login.config

  #call generic define for setting java options parameter

}
