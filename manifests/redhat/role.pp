define tomcat::redhat::role($tomcat_instance_root_dir, $tomcat_instance_number, $rolename, $ensure = present) {

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"

  if $ensure in [ present, absent ] {
    $ensure_real = $ensure
  }
  else {
    fail("Tomcat::Conf::Role[${rolename}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        augeas { "tomcat-users/role/$rolename/rm" :
          lens    => 'Xml.lns',
          incl    => "${real_tomcat_instance_dir}/conf/tomcat-users.xml",
          context => "/files/${real_tomcat_instance_dir}/conf/tomcat-users.xml",
          changes => [
            "rm tomcat-users/role[.][#attribute/rolename = $rolename]",
          ],
          onlyif  => "match tomcat-users/role/#attribute/rolename[. =\"$rolename\"] size > 0",
          require => File["${real_tomcat_instance_dir}/conf/tomcat-users.xml"]
        }
      }
    'present':
      {
        augeas { "tomcat-users/role/$rolename/add" :
          lens    => 'Xml.lns',
          incl    => "${real_tomcat_instance_dir}/conf/tomcat-users.xml",
          context => "/files/${real_tomcat_instance_dir}/conf/tomcat-users.xml",
          changes => [
            "set tomcat-users/role[last()+1]/#attribute/rolename $rolename",
          ],
          onlyif  => "match tomcat-users/role/#attribute/rolename[. =\"$rolename\"] size == 0",
          require => File["${real_tomcat_instance_dir}/conf/tomcat-users.xml"]
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

}
