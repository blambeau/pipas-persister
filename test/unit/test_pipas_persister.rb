require 'spec_helper'
describe 'PipasPersister' do

  it 'loads and sets a version number' do
    PipasPersister::VERSION.should_not be_nil
  end

end