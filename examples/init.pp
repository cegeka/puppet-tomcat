tomcat::conf::setenv { 'setting env':
  java_options => [
    'JAVA_XMS="512m"',
    'JAVA_XMX="1024m"',
    'JAVA_PERMSIZE="256m"',
    'JAVA_MAXPERMSIZE="512m"',
    'ADD_JAVA_OPTS="-Denv.MRT_ENVIRONMENT=s4t"'
  ],
}

tomcat::conf::role { 'adding tomcat role':
  rolename => 'bla'
}

tomcat::conf::user { 'adding user':
  username => 'renta',
  password => 'renta',
  roles    => 'manager-gui'
}

