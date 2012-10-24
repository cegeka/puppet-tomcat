require 'spec_helper'

describe 'tomcat::instance::user' do

  context 'adding tomcat user' do
    #context 'without the required parameters' do
    #  let (:title) { 'add tomcat user' }
    #  let (:facts) { { :operatingsystem => 'redhat' } }

    #  it {
    #    expect { subject }.to raise_error(
    #      Puppet::Error, /parameters username, password and roles must be defined/
    #  )}
    #end

    #context 'without password parameter' do
    #  let (:title) { 'add tomcat user' }
    #  let (:facts) { { :operatingsystem => 'redhat' } }
    #  let(:params) { { :tomcat_instance_root_dir => '/data', :tomcat_instance_number => '00', :username => 'tomcat', :roles => 'manager-gui,foo' } }

    #  it {
    #    expect { subject }.to raise_error(
    #      Puppet::Error, /parameters username, password and roles must be defined/
    #  )}
    #end

    context 'with all required parameters specified username, password and roles parameter' do
      let (:title) { 'add tomcat user' }
      let (:facts) {{ :operatingsystem => 'redhat' }}
      let(:params) { { :tomcat_instance_root_dir => '/data', :tomcat_instance_number => '00', :username => 'tomcat', :password => 'tomcat', :roles => 'manager-gui,foo' } }

      it {
        should contain_augeas('tomcat-users/user/tomcat/rm').with(
          :context => "/files/data/tomcat00/conf/tomcat-users.xml",
          :changes => [
            "rm tomcat-users/user[.][#attribute/username = tomcat]"
          ],
          :require => "File[/data/tomcat00/conf/tomcat-users.xml]"
        )
      }

      it {
        should contain_augeas('tomcat-users/user/tomcat/add').with(
          :context => "/files/data/tomcat00/conf/tomcat-users.xml",
          :changes => [
            "set tomcat-users/user[last()+1]/#attribute/username tomcat",
            "set tomcat-users/user[last()]/#attribute/password tomcat",
            "set tomcat-users/user[last()]/#attribute/roles manager-gui,foo",
          ]
        )
      }
    end
  end

  context 'removing tomcat user' do
    let (:title) { 'remove tomcat user' }
    let (:facts) {{ :operatingsystem => 'redhat' }}
    let(:params) { { :tomcat_instance_root_dir => '/data', :tomcat_instance_number => '00', :username => 'tomcat', :ensure => 'absent' } }

    it {
      should contain_augeas('tomcat-users/user/tomcat/rm').with(
        :context => "/files/data/tomcat00/conf/tomcat-users.xml",
        :changes => [
            "rm tomcat-users/user[.][#attribute/username = tomcat]"
        ],
        :require => "File[/data/tomcat00/conf/tomcat-users.xml]"
      )
    }
  end

end
