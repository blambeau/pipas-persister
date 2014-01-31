require 'spec_helper'
module PipasPersister
  describe Operation, "precondition" do

    let(:operation) {
      Class.new(Operation) {
        precondition "foo" do |input|
          false
        end
      }
    }

    it 'should add the precondition to the class collection' do
      operation.preconditions.size.should eq(1)
    end

  end
end
