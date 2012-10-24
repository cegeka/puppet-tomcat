# Environment variables
$tomcat_version = '6.0.32-4'
$tomcat_instance_root_dir = '/data'

# Install tomcat $version
tomcat::server { "tomcat-${tomcat_version}":
  tomcat_version => $tomcat_version,
}

# Create a tomcat instance $name
tomcat::instance { 'tomcat00':
  tomcat_instance_root_dir    => $tomcat_instance_root_dir,
  tomcat_instance_number      => '00',
  tomcat_instance_gid         => '1001',
  tomcat_instance_uid         => '1101',
  tomcat_instance_password    => '$1$JOOZyS5c$JDJq9SdMWVZi8IRT/Lh2H1',
  tomcat_version              => $tomcat_version,
  tomcat_options              => [
    { 'SERVER_PORT'           => '8050' },
    {  'HTTP_PORT'            => '8080' },
    {  'AJP_PORT'             => '8010' },
    {  'TOMCAT_INSTANCE_PROPS' => '"-Xmx256m -XX:MaxPermSize=128m
        -Dtn.tomcat.server.port=$SERVER_PORT -Dtn.tomcat.connector.http.port=$HTTP_PORT
        -Dtn.tomcat.connector.ajp.port=$AJP_PORT
        -Dtn.tomcat.connector.ajp.maxThreads=200
        -Dtn.tomcat.engine.jvmRoute=${TOMCAT_NAME}${TOMCAT_NUMBER}"' }
  ]
}

# Configure settings for the tomcat instance
tomcat::instance::role { 'adding foo role':
  tomcat_instance_root_dir => $tomcat_instance_root_dir,
  tomcat_instance_number   => '00',
  rolename                 => 'foo'
}

tomcat::instance::user { 'adding tomcat user':
  tomcat_instance_root_dir => $tomcat_instance_root_dir,
  tomcat_instance_number   => '00',
  username                 => 'tomcat',
  password                 => 'tomcat',
  roles                    => 'manager-gui, foo'
}

tomcat::instance::jaas { 'setting tomcat jaas config':
  tomcat_instance_root_dir => $tomcat_instance_root_dir,
  tomcat_instance_number   => '00',
  loginconf                => "simbaJAAS {
        org.test.jaas.loginmodule.DatabaseLoginModule SUFFICIENT debug=true;
        org.test.jaas.loginmodule.FallbackDatabaseLoginModule REQUIRED debug=true;
    };\n"
}
