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
      yum::versionlock { "0:cegeka-tomcat${tomcat_major_version}-${tomcat_version}.*": }
    }
    false: {
      yum::versionlock { "0:cegeka-tomcat${tomcat_major_version}-${tomcat_version}.*": ensure => absent }
    }
    default: { fail('Class[Tomcat::Redhat::Server]: parameter versionlock must be true or false')}
  }

}
