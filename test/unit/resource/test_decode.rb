require 'spec_helper'
module PipasPersister
  describe Resource, "decode" do

    let(:resource){
      Resource.new({ "schema" => schema })
    }

    let(:schema){
      { "size" => "float" }
    }

    subject{ resource.decode(body) }

    context 'when ok' do
      let(:body){ { "size" => "1.0" } }

      it 'should return the value' do
        subject.should eq(Tuple(:size => 1.0))
      end
    end

    context 'when missing size' do
      let(:body){ {} }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ResourceTypeError, /Missing `size` attribute/)
      end
    end

    context 'when uncoercable size' do
      let(:body){ { "size" => "foo" } }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ResourceTypeError, /Invalid float 'foo' @ `size`/)
      end
    end

    context 'when uncoercable at deep location' do
      let(:schema){
        { "info" => { "size" => "float" } }
      }
      let(:body){ {"info" => { "size" => "foo" } } }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(ResourceTypeError, /Invalid float 'foo' @ `info\/size`/)
      end
    end

  end
end
