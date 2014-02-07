require 'spec_helper'
module PipasPersister
  class Resource
    describe ScalarType, "decode" do

      let(:type){ ScalarType.new("ff", Float) }

      subject{
        type.decode(arg)
      }

      context 'with a float' do
        let(:arg){ 1.0 }

        it{ should be(arg) }
      end

      context 'with a coercable value' do
        let(:arg){ "1.0" }

        it{ should eq(1.0) }
      end

      context 'with a non-coercable value' do
        let(:arg){ "foo" }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, "Invalid ff 'foo'")
        end
      end

    end
  end
end
