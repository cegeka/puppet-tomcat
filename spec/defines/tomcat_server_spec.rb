require 'spec_helper'

describe 'tomcat::server' do

  context 'installing tomcat server' do
    let (:title) { 'installing tomcat server package' }
    let (:facts) { { :operatingsystem => 'redhat' } }
    let(:params) { { :tomcat_version => '6.0.32-4' } }

    let(:pre_condition) { "define yum::repo($scheme, $host, $repo_root, $ensure = present, $descr = undef, $enabled = '1', $gpgcheck = '1', $sslverify = 'False', $sslcacert = undef, $sslclientcert = undef, $sslclientkey = undef, $metadata_expire = undef) {}" "class yum {}" }

    it { should contain_package('httplog').with(
        :ensure => 'present'
      )
    }

    it { should contain_package("cegeka-tomcat6").with(
      :ensure => '6.0.32-4'
      )
    }
  end

end
