define tomcat::redhat::setenv($instance=true, $tomcat_instance_root_dir=undef, $tomcat_instance_number=undef, $java_options=undef) {

  case $instance {
    true:
    {
      file { "${tomcat_instance_root_dir}/tomcat${tomcat_instance_number}/bin/setenv.sh":
        ensure  => file,
        content => template("${module_name}/bin/setenv.sh.erb"),
        owner   => "tomcat${tomcat_instance_number}",
        group   => "tomcat${tomcat_instance_number}",
        mode    => '0754',
      }
    }
    false:
    {
      if $::tomcat_installation_dir == undef {
        fail("parameter $::tomcat_installation_dir is undefined")
      }

      file { "${::tomcat_installation_dir}/bin/setenv.sh":
        ensure  => file,
        content => template("${module_name}/bin/setenv.sh.erb"),
        owner   => 'tomcat',
        group   => 'tomcat',
        mode    => '0754',
      }
    }
    default: { fail("Tomcat::Redhat::Setenv[${title}]: parameter instance must be a boolean")  }
  }

}
