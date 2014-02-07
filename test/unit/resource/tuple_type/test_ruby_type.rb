require 'spec_helper'
module PipasPersister
  class Resource
    describe TupleType, "ruby_type" do

      let(:type){ TupleType["size" => "float"] }

      subject{
        type.ruby_type
      }

      it{
        should eq(Tuple[size: Float])
      }
    end
  end
end
