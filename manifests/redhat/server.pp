define tomcat::redhat::server(
  $tomcat_version=undef,
  $version_lock=false
) {

  include yum
  include stdlib::packages

  if !$tomcat_version {
    fail('Class[Tomcat::Redhat::Server]: parameter tomcat_version must be provided')
  }

  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)-(\d+)$','\1')

  debug("tomcat_major_version=${tomcat_major_version}")
  debug("tomcat_version=${tomcat_version}")

  Package <| title == httplog |> -> Package["cegeka-tomcat${tomcat_major_version}"]

  package { "cegeka-tomcat${tomcat_major_version}":
    ensure => $tomcat_version,
  }

  case $version_lock {
    true: {
      packagelock { "cegeka-tomcat${tomcat_major_version}": }
    }
    false: {
      packagelock { "cegeka-tomcat${tomcat_major_version}": ensure => absent }
    }
    default: { fail('Class[Tomcat::Redhat::Server]: parameter version_lock must be true or false')}
  }

}
