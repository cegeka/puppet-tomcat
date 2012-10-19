$tomcat_version = '6.0.32'

tomcat::server { 'tomcat server':
  tomcat_version => '6.0.32',
}

tomcat::instance { 'tomcat00 instance':
  tomcat_instance_root_dir => '/data',
  tomcat_instance_number   => '00',
  tomcat_instance_gid      => '1001',
  tomcat_instance_uid      => '1101',
  tomcat_instance_password => '$1$JOOZyS5c$JDJq9SdMWVZi8IRT/Lh2H1',
  tomcat_version           => '6.0.32',
  tomcat_options           => { 'SERVER_PORT' => '8050', 'HTTP_PORT' => '8080', 'AJP_PORT' => '8010' }
}

tomcat::instance { 'tomcat01 instance':
  tomcat_instance_root_dir => '/data',
  tomcat_instance_number   => '01',
  tomcat_instance_gid      => '1002',
  tomcat_instance_uid      => '1102',
  tomcat_instance_password => '$1$8WHwrwUf$JmAywFDPdE4CwyjaNHn010',
  tomcat_version           => '6.0.32',
  tomcat_options           => { 'SERVER_PORT' => '8051', 'HTTP_PORT' => '8081', 'AJP_PORT' => '8011' }
}

#tomcat::conf::setenv { 'setting tomcat env':
#  java_options => [
#    '-Xms512m',
#    '-Xmx1024m',
#    '-XX:PermSize=256m',
#    '-XX:MaxPermSize=512m',
#    '-Denv.ENVIRONMENT=test'
#  ],

#}

#tomcat::conf::role { 'adding foo role':
#  rolename => 'foo'
#}

#tomcat::conf::user { 'adding tomcat user':
#  username => 'tomcat',
#  password => 'tomcat',
#  roles    => 'manager-gui, foo'
#}

