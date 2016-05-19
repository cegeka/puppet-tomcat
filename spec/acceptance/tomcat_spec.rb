require 'spec_helper_acceptance'

describe 'tomcat' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include stdlib
        include stdlib::stages
        include profile::package_management

        $tomcat_version = '7.0.65-3.cgk.el6'
        $tomcat_instance_root_dir = '/opt'

        class { 'cegekarepos' : stage => 'setup_repo' }
        
        Yum::Repo <| title == 'cegeka-custom' |>
        Yum::Repo <| title == 'cegeka-custom-noarch' |>
        Yum::Repo <| title == 'cegeka-unsigned' |>
        
        sunjdk::instance { 'jdk-1.7.0_06-fcs':
          ensure      => 'present',
          jdk_version => '1.7.0_06-fcs'
        }

        tomcat::server { "tomcat-${tomcat_version}":
          tomcat_version => $tomcat_version,
          versionlock    => true
        }

      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('cegeka-tomcat7-7.0.65-3.cgk.el6.noarch') do
      it { should be_installed }
    end
  end
end
