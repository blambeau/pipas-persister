require 'spec_helper'
module PipasPersister
  class Operation
    describe UpdateAppointment do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/update-appointment')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        UpdateAppointment.new(@connection).call(input)
      }

      context 'to fix an appointment' do
        let(:uuid){
          "e5f18eb0-671d-0131-38d1-3c07545ed162"
        }

        let(:input){
          Tuple(appointment_id: uuid, fixed: true, duration: 123)
        }

        before do
          subject
        end

        it 'should work correctly and update it' do
          uuid = self.uuid
          @connection.tuple_extract{
            restrict(base.appointments, appointment_id: uuid)
          }[:fixed].should eq(true)
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
