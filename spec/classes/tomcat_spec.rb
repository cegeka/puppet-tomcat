#!/usr/bin/env rspec

require 'spec_helper'

describe 'tomcat' do

  context "with RedHat as OS" do
    let (:facts) {{ :operatingsystem => 'redhat' }}
    
    it { should contain_package('tomcat').with_ensure('present') }
    it { should contain_service('tomcat').with_ensure('running') }
  end

end
