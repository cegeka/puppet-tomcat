require 'spec_helper'

describe 'tomcat::server' do

  context 'installing tomcat server' do
    let (:title) { 'installing tomcat server package' }
    let (:facts) { { :operatingsystem => 'redhat' } }
    let(:params) { { :tomcat_version => '6.0.32-4' } }

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
