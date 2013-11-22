tomcat::conf::jaas { 'security setup':
  loginconf     => "JAAS {
        foo.bar.jaas.loginmodule.DatabaseLoginModule SUFFICIENT debug=true;
        foo.bar.jaas.loginmodule.FallbackDatabaseLoginModule REQUIRED debug=true;
  };",
  java_options  => [
    '-Dsecurity.url=http://localhost:8080/security'
  ]
}
