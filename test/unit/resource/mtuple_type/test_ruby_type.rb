require 'spec_helper'
module PipasPersister
  class Resource
    describe MTupleType, "ruby_type" do

      let(:type){ Type["size (?)" => "float"] }

      subject{
        type.ruby_type
      }

      it{
        should be(Hash)
      }
    end
  end
end
