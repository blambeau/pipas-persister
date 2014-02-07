require 'spec_helper'
module PipasPersister
  class Resource
    describe ScalarType, "ruby_type" do

      let(:type){ ScalarType.new("ff", Float) }

      subject{
        type.ruby_type
      }

      it{
        should be(Float)
      }

    end
  end
end
