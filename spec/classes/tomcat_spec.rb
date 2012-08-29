#!/usr/bin/env rspec

require 'spec_helper'

describe 'tomcat' do
  it { should contain_class 'tomcat' }
end
