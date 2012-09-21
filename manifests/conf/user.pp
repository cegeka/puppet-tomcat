define tomcat::conf::user($username, $password, $roles, $ensure = present) {

  include tomcat::conf

  if $ensure in [ present, absent ] {
    $ensure_real = $ensure
  }
  else {
    fail("Tomcat::Conf::User[${username}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        Augeas <| title == "tomcat-users/user/$username/rm"  |>
      }
    'present':
      {
        Augeas <| title == "tomcat-users/user/$username/rm"  |>

        augeas { "tomcat-users/user/$username/add" :
          lens    => 'Xml.lns',
          incl    => '/opt/tomcat/conf/tomcat-users.xml',
          context => '/files/opt/tomcat/conf/tomcat-users.xml',
          changes => [
            "set tomcat-users/user[last()+1]/#attribute/username $username",
            "set tomcat-users/user[last()]/#attribute/password $password",
            "set tomcat-users/user[last()]/#attribute/roles $roles",
          ],
          onlyif  => "match tomcat-users/user/#attribute/username[. =\"$username\"] size == 0",
          require => Augeas["tomcat-users/user/$username/rm"]
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "tomcat-users/user/$username/rm" :
    lens    => 'Xml.lns',
    incl    => '/opt/tomcat/conf/tomcat-users.xml',
    context => '/files/opt/tomcat/conf/tomcat-users.xml',
    changes => [
      "rm tomcat-users/user[.][#attribute/username = $username]",
    ],
    onlyif  => "match tomcat-users/user/#attribute/username[. =\"$username\"] size > 0",
    require => File['/opt/tomcat/conf/tomcat-users.xml']
  }

}
