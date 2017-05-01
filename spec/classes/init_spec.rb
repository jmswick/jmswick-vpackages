require 'spec_helper'
describe 'vpackages' do

  context 'with defaults for all parameters' do
    it { should contain_class('vpackages') }
  end
end
