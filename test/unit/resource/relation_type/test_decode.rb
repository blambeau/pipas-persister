require 'spec_helper'
module PipasPersister
  class Resource
    describe RelationType, "decode" do

      let(:type){ RelationType[[{"size" => "float"}]] }

      subject{
        type.decode(arg)
      }

      context 'with a valid relation' do
        let(:arg){ [{"size" => 1.0}, {"size" => "2.0"}] }

        it{ should eq(Relation(size: [1.0, 2.0])) }
      end

      context 'when not an array' do
        let(:arg){ "foo" }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, /Invalid relation 'foo'/)
        end
      end

      context 'when invalid tuple' do
        let(:arg){ [{"size" => 1.0}, {}] }

        it 'should raise an error' do
          ->{
            subject
          }.should raise_error(ResourceTypeError, /Missing `size` attribute @ `\[1\]`/)
        end
      end

    end
  end
end
