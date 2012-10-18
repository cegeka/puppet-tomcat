define tomcat::instance($tomcat_instance_root_dir, $tomcat_instance_number, $tomcat_instance_uid, $tomcat_instance_gid) {

  include tomcat

  case $::operatingsystem {
      redhat, centos: { 
         class { 'tomcat::redhat::instance':
           tomcat_instance_root_dir => $tomcat_instance_root_dir,
           tomcat_instance_number   => $tomcat_instance_number,
           tomcat_instance_uid      => $tomcat_instance_uid,
           tomcat_instance_gid      => $tomcat_instance_gid,
         }
      }
      default: { fail("operatingsystem ${::operatingsystem} is not supported") }
  }

}
