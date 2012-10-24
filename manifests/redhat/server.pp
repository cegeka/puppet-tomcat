define tomcat::redhat::server($tomcat_version) {

  include yum

  $tomcat_major_version = regsubst($tomcat_version, '^(\d+)\.(\d+)\.(\d+)-(\d+)$','\1')

  debug("tomcat_major_version=${tomcat_major_version}")
  debug("tomcat_version=${tomcat_version}")

  Yum::Repo['cegeka-public'] -> Package['httplog'] -> Package["cegeka-tomcat${tomcat_major_version}"]

  if ! defined(Yum::Repo['cegeka-public']) {
    yum::repo { 'cegeka-public':
      ensure          => present,
      scheme          => 'https',
      host            => 'yum.cegeka.be',
      repo_root       => 'cegeka-public',
      descr           => 'Cegeka public RPM repo',
      enabled         => '1',
      sslverify       => 'True',
      sslcacert       => '/etc/pki/tls/certs/ca-bundle.crt',
      metadata_expire => '5m',
    }
  }

  package { "cegeka-tomcat${tomcat_major_version}":
    ensure => $tomcat_version,
  }

  package { 'httplog':
    ensure => present,
  }

}
