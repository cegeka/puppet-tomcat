define tomcat::instance(
    $tomcat_instance_root_dir,
    $tomcat_instance_number,
    $tomcat_instance_uid,
    $tomcat_instance_gid,
    $tomcat_instance_password,
    $tomcat_version,
    $tomcat_options,
    $tomcat_jmx_enabled=false,
    $tomcat_jmx_port=undef,
    $tomcat_jmx_serverport=undef
  ) {

  if $tomcat_instance_number !~ /^[0-9]+$/ {
    fail("Tomcat::Instance[${title}]: parameter tomcat_instance_number must be numeric")
  }

  case $::operatingsystem {
    redhat, centos: {
      tomcat::redhat::instance { $name:
        tomcat_instance_root_dir => $tomcat_instance_root_dir,
        tomcat_instance_number   => $tomcat_instance_number,
        tomcat_instance_uid      => $tomcat_instance_uid,
        tomcat_instance_gid      => $tomcat_instance_gid,
        tomcat_instance_password => $tomcat_instance_password,
        tomcat_version           => $tomcat_version,
        tomcat_options           => $tomcat_options,
        tomcat_jmx_enabled       => $tomcat_jmx_enabled,
        tomcat_jmx_port          => $tomcat_jmx_port,
        tomcat_jmx_serverport    => $tomcat_jmx_serverport
      }
    }
    default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
