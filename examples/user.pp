tomcat::conf::user { 'adding tomcat user':
  username => 'tomcat',
  password => 'tomcat',
  roles    => 'manager-gui, foo'
}
