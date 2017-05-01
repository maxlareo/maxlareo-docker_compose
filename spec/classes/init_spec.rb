require 'spec_helper'
describe 'docker_compose' do

  context 'with defaults for all parameters' do
    it { should contain_class('docker_compose') }
  end
end
