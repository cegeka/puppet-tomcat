define tomcat::redhat::server(
  $tomcat_version=undef,
  $versionlock=false
) {

  include yum

  @package { 'httplog':
    ensure => present,
  }

  if !$tomcat_version {
    fail('Class[Tomcat::Redhat::Server]: parameter tomcat_version must be provided')
  }

  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)-(\d+).*','\1')

  Package <| title == httplog |> -> Package["cegeka-tomcat${tomcat_major_version}"]

  package { "cegeka-tomcat${tomcat_major_version}":
    ensure => $tomcat_version,
  }

  case $versionlock {
    true: {
      yum::versionlock { "cegeka-tomcat${tomcat_major_version}":
        ensure  => present,
        version => regsubst($tomcat_version, '^(.*?)-(.*)','\1'),
        release => regsubst($tomcat_version, '^(.*?)-(.*)','\2'),
        epoch   => 0,
        arch    => 'noarch',
      }
    }
    false: {
      yum::versionlock { "cegeka-tomcat${tomcat_major_version}":
        ensure  => absent,
        version => regsubst($tomcat_version, '^(.*?)-(.*)','\1'),
        release => regsubst($tomcat_version, '^(.*?)-(.*)','\2'),
        epoch   => 0,
        arch    => 'noarch',
      }
    }
    default: { fail('Class[Tomcat::Redhat::Server]: parameter versionlock must be true or false')}
  }

}
