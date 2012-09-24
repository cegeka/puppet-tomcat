require 'spec_helper'

describe 'tomcat::conf::setenv' do

  context 'setting tomcat env' do
    let (:title) { 'setting env' }
    let (:facts) {{ :operatingsystem => 'redhat' }}
    let(:params) { { :java_options => [ '-Xms512m', '-Xmx1024m', '-XX:PermSize=256m', '-XX:MaxPermSize=512m', '-Denv.ENVIRONMENT=test'] } }

    it { should contain_class('tomcat') }

    it {
      should contain_file('/opt/tomcat/bin/setenv.sh').with(
        :ensure => 'file',
        :owner => 'tomcat',
        :group => 'tomcat',
        :mode => '0754'
      ).with_content(/^export JAVA_OPTS=\"-Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m -Denv\.ENVIRONMENT=test\"$/)
    }
  end

end
