require 'spec_helper'
module PipasPersister
  class Resource
    describe RelationType, "ruby_type" do

      let(:type){ RelationType[[{"size" => "float"}]] }

      subject{
        type.ruby_type
      }

      it{
        should eq(Relation[size: Float])
      }

    end
  end
end
