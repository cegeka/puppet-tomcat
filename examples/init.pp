class { 'tomcat': }

tomcat::conf::setenv { 'setting tomcat env':
  java_options => [
    'JAVA_XMS="512m"',
    'JAVA_XMX="1024m"',
    'JAVA_PERMSIZE="256m"',
    'JAVA_MAXPERMSIZE="512m"',
    'ADD_JAVA_OPTS="-Denv.ENVIRONMENT=test"'
  ],
}

tomcat::conf::role { 'adding foo role':
  rolename => 'foo'
}

tomcat::conf::user { 'adding user':
  username => 'tomcat',
  password => 'tomcat',
  roles    => 'manager-gui, foo'
}

