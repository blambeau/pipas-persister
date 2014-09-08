require 'spec_helper'
module PipasPersister
  class Operation
    describe AddUnavailability do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/add-unavailability')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        AddUnavailability.new(@connection).call(input)
      }

      context 'to add an unavailability' do
        let(:uuid){
          "d9026fa0-66ff-0131-38cb-3c07545ed162"
        }

        unavailable_at = Time.parse("2014-05-24 09:00:00")

        let(:input){
          Tuple(treatment_id: uuid, unavailable_at: unavailable_at, reason: "no reason")
        }

        before do
          subject
        end

        it 'should work correctly and insert it' do
          uuid = self.uuid
          @connection.relvar{
            restrict(base.patient_unavailabilities, treatment_id: uuid, unavailable_at: unavailable_at)
          }.should_not be_empty
        end

        it 'should upate the scheduling problem' do
          sch = @connection.tuple_extract{
            base.scheduling
          }
          sch[:problem_key].should_not eq("c7d96640-6bed-0131-39a9-3c07545ed162")
          (Time.now - sch[:last_modified] < 1.0).should be_true
        end
      end

    end
  end
end
