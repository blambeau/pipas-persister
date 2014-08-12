require 'spec_helper'
module PipasPersister
  class Operation
    describe UpdateUnavailabilities do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/update-unavailabilities')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        UpdateUnavailabilities.new(@connection).call(input)
      }

      context 'to add an unavailability' do
        let(:uuid){
          "d9027510-66ff-0131-38cb-3c07545ed162"
        }

        unavailable_at = Time.parse("2014-05-24 09:00:00")

        let(:input){
          Tuple(treatment_id: uuid, unavailable_at: unavailable_at)
        }

        before do
          subject
        end

        it 'should work correctly and add it' do
          uuid = self.uuid
          @connection.tuple_extract{
            restrict(base.patient_unavailabilities, treatment_id: uuid)
          }[:unavailable_at].should eq(unavailable_at)
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
