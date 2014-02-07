require 'spec_helper'
describe 'The resource files' do

  PipasPersister::RESOURCES_FOLDER.glob('**/*.json').each do |file|
    describe file.basename do

      it 'should load without error' do
        lambda{
          file.load
        }.should_not raise_error
      end

      it 'should properly compile to a Resource' do
        ->{
          r = PipasPersister::Resource.new(file.load)
          r.schema
        }.should_not raise_error
      end

    end
  end

end
