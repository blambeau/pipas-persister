require 'spec_helper'
module PipasPersister
  describe Resource, "[]" do

    subject{ Resource[arg] }

    context 'on existing resource' do
      let(:arg){ '/scheduling/solution' }

      it{ should be_a(Resource) }
    end

    context 'on unexisting resource' do
      let(:arg){ '/no/such/one' }

      it 'should raise an error' do
        ->{
          subject
        }.should raise_error(NoSuchResourceError)
      end
    end

  end
end
