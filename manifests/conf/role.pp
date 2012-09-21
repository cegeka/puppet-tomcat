define tomcat::conf::role($rolename, $ensure = present) {

  include tomcat::conf::conf

  if $ensure in [ present, absent ] {
    $ensure_real = $ensure
  }
  else {
    fail("Tomcat::Conf::Role[${rolename}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        augeas { "tomcat-users/roles/$rolename/rm" :
          lens    => 'Xml.lns',
          incl    => '/opt/tomcat/conf/tomcat-users.xml',
          context => '/files/opt/tomcat/conf/tomcat-users.xml',
          changes => [
            "rm tomcat-users/role[.][#attribute/rolename = $rolename]",
          ],
          onlyif  => "match tomcat-users/role/#attribute/rolename[. =\"$rolename\"] size > 0",
          require => File['/opt/tomcat/conf/tomcat-users.xml']
        }
      }
    'present':
      {
        augeas { "tomcat-users/role/$rolename/add" :
          lens    => 'Xml.lns',
          incl    => '/opt/tomcat/conf/tomcat-users.xml',
          context => '/files/opt/tomcat/conf/tomcat-users.xml',
          changes => [
            "set tomcat-users/role[last()+1]/#attribute/rolename $rolename",
          ],
          onlyif  => "match tomcat-users/role/#attribute/rolename[. =\"$rolename\"] size == 0",
          require => File['/opt/tomcat/conf/tomcat-users.xml']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

}
