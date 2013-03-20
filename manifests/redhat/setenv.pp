define tomcat::redhat::setenv($ensure,
  $tomcat_instance_root_dir,
  $tomcat_instance_number,
  $java_options
) {

  $tomcat_instance_name = "tomcat${tomcat_instance_number}"
  $real_tomcat_instance_dir = "${tomcat_instance_root_dir}/${tomcat_instance_name}"

  File {
    owner => $tomcat_instance_name,
    group => $tomcat_instance_name
  }

  file { "${real_tomcat_instance_dir}/bin/setenv.sh":
    ensure  => $ensure,
    content => template("${module_name}/bin/setenv.sh.erb"),
    mode    => '0754',
  }

}
