tomcat::conf::setenv { 'setting tomcat env':
  java_options => [
    '-Xms512m',
    '-Xmx1024m',
    '-XX:PermSize=256m',
    '-XX:MaxPermSize=512m',
    '-Denv.ENVIRONMENT=test'
  ],
}
