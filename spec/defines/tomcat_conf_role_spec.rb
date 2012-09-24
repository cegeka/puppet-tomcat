require 'spec_helper'

describe 'tomcat::conf::role' do

  context 'adding tomcat role' do
    let (:title) { 'add foo role' }
    let (:facts) {{ :operatingsystem => 'redhat' }}
    let(:params) { { :rolename => 'foo' } }

    it { should contain_class('tomcat') }

    it {
      should contain_file('/opt/tomcat/conf/tomcat-users.xml').with(
        :ensure => 'file',
        :owner => 'tomcat',
        :group => 'tomcat',
        :mode => '0644'
      )
    }

    it {
      should contain_augeas('tomcat-users/role/foo/add').with(
        :context => "/files/opt/tomcat/conf/tomcat-users.xml",
        :changes => ["set tomcat-users/role[last()+1]/#attribute/rolename foo"]
      )
    }
  end

  context 'removing tomcat role' do
    let (:title) { 'remove foo role' }
    let (:facts) {{ :operatingsystem => 'redhat' }}
    let(:params) { { :rolename => 'foo', :ensure => 'absent' } }

    it { should contain_class('tomcat') }

    it {
      should contain_file('/opt/tomcat/conf/tomcat-users.xml').with(
        :ensure => 'file',
        :owner => 'tomcat',
        :group => 'tomcat',
        :mode => '0644'
      )
    }

    it {
      should contain_augeas('tomcat-users/role/foo/rm').with(
        :context => "/files/opt/tomcat/conf/tomcat-users.xml",
        :changes => ["rm tomcat-users/role[.][#attribute/rolename = foo]"]
      )
    }
  end

end
