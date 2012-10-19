define tomcat::redhat::setenv($java_options=undef) {

  #include tomcat

  file { "${::tomcat_installation_dir}/bin/setenv.sh":
    ensure  => file,
    content => template("${module_name}/bin/setenv.sh.erb"),
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0754',
  }

}
