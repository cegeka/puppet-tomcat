define tomcat::instance($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_instance_uid, $tomcat_instance_gid, $tomcat_instance_password) {

  include tomcat

  notice("uid= ${tomcat_instance_uid}")
  notice("uid= ${tomcat::tomcat_instance_uid}")
  notice("uid= ${tomcat::instance::tomcat_instance_uid}")

  case $::operatingsystem {
      redhat, centos: { 
         class { 'tomcat::redhat::instance':
           tomcat_instance_root_dir => $tomcat_instance_root_dir,
           tomcat_instance_number   => $tomcat_instance_number,
           tomcat_instance_uid      => $tomcat_instance_uid,
           tomcat_instance_gid      => $tomcat_instance_gid,
           tomcat_instance_password => $tomcat_instance_password,
         }
      }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
