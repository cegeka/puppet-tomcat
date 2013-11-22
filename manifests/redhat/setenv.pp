define tomcat::redhat::setenv($ensure=undef,$instance=true, $tomcat_instance_root_dir=undef, $tomcat_instance_number=undef, $java_options=undef) {

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"

  case $instance {
    true:
    {
      file { "${real_tomcat_instance_dir}/bin/setenv.sh":
        ensure  => $ensure,
        content => template("${module_name}/bin/setenv.sh.erb"),
        owner   => "tomcat${tomcat_instance_number}",
        group   => "tomcat${tomcat_instance_number}",
        mode    => '0664',
      }
    }
    false:
    {
      if $::tomcat_installation_dir == undef {
        fail("parameter ${::tomcat_installation_dir} is undefined")
      }

      file { "${::tomcat_installation_dir}/bin/setenv.sh":
        ensure  => $ensure,
        content => template("${module_name}/bin/setenv.sh.erb"),
        owner   => 'tomcat',
        group   => 'tomcat',
        mode    => '0664',
      }
    }
    default: { fail("Tomcat::Redhat::Setenv[${title}]: parameter instance must be a boolean")  }
  }

}
