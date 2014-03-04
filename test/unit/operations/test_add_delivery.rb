require 'spec_helper'
module PipasPersister
  class Operation
    describe AddDelivery do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/add-delivery')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        AddDelivery.new(@connection).call(input)
      }

      context 'to create a fresh new delivery' do
        let(:input){
          Tuple(
            delivery_id: "a-fresh-new-uuid",
            treatment_id: "d9027510-66ff-0131-38cb-3c07545ed162",
            step_id: "74685ae0-66fd-0131-38cb-3c07545ed162",
            delivered_at: Time.parse("2014-03-04T12:04"),
            delivered_dose: 0.75
          )
        }

        before do
          subject
        end

        it 'should work correctly and insert it' do
          @connection.relvar{
            restrict(base.deliveries, delivery_id: "a-fresh-new-uuid")
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
