require 'spec_helper'
module PipasPersister
  class Resource
    describe Type, "compile" do

      subject{ Type.compile(arg) }

      context 'with a scalar type name' do
        let(:arg){ "float" }

        it do
          should be_a(ScalarType)
        end

        it 'should have Float class as coercer' do
          subject.coercer.should be(Float)
        end
      end

      context 'with a hash with all required fields' do
        let(:arg){
          { "size" => "float" }
        }

        it do
          should be_a(TupleType)
        end

        it 'should have expected coercers' do
          subject.coercers.keys.should eq([:size])
          subject.coercers[:size].should be_a(Array)
          subject.coercers[:size].first.should eq(true)
          subject.coercers[:size].last.coercer.should be(Float)
        end
      end

      context 'with a hash with some optional fields' do
        let(:arg){
          { "size" => "float", "hobby (?)" => "float" }
        }

        it do
          should be_a(MTupleType)
        end

        it 'should have expected coercers' do
          subject.coercers.keys.should eq([:size, :hobby])

          subject.coercers[:size].should be_a(Array)
          subject.coercers[:size].first.should eq(true)
          subject.coercers[:size].last.coercer.should be(Float)

          subject.coercers[:hobby].should be_a(Array)
          subject.coercers[:hobby].first.should eq(false)
          subject.coercers[:hobby].last.coercer.should be(Float)
        end
      end

      context 'with an array of one hash' do
        let(:arg){
          [{ "size" => "float" }]
        }

        it do
          should be_a(RelationType)
        end

        it 'should have expected coercers' do
          subject.coercer.should be_a(TupleType)
        end
      end

    end
  end
end
