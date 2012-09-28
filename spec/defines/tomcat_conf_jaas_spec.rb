require 'spec_helper'

describe 'tomcat::conf::jaas' do

  context 'security setup' do
    let (:title) { 'security setup' }
    let (:facts) { { :operatingsystem => 'redhat' } }
    let(:params) { { :loginconf => "JAAS { foo bar }", :java_options => [ '-Dsecurity.url=http://localhost:8080'] } }

    it { should contain_class('tomcat') }

    it {
      should contain_file('/opt/tomcat/conf/login.conf').with(
        :ensure => 'file',
        :owner => 'tomcat',
        :group => 'tomcat',
        :mode => '0644'
      ).with_content(/JAAS \{ foo bar \}/)
    }
  end

end
