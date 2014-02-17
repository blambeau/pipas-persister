require 'spec_helper'
module PipasPersister
  class Resource
    describe TupleType, "decode" do

      let(:type){ TupleType["size" => "float"] }

      subject{
        type.decode(arg)
      }

      context 'with a valid tuple' do
        let(:arg){ {"size" => 1.0} }

        it{ should eq(Tuple(size: 1.0)) }
      end

      context 'when not a Hash' do
        let(:arg){ "bar" }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, /Invalid tuple 'bar'/)
        end
      end

      context 'with missing attribute' do
        let(:arg){ {} }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, /Missing `size` attribute/)
        end
      end

      context 'with extra attribute' do
        let(:arg){ {"size" => 1.0, "foo" => "bar"} }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, /Unrecognized attribute `foo`/)
        end
      end

      context 'with deeper error' do
        let(:arg){ { "size" => "foo" } }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, /Invalid float 'foo' @ `size`/)
        end
      end

    end
  end
end
