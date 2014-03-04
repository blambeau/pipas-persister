require 'spec_helper'
module PipasPersister
  class Operation
    describe AddTreatment do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/add-treatment')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        AddTreatment.new(@connection).call(input)
      }

      context 'to create a fresh new delivery' do
        let(:input){
          Tuple(
            treatment_id: "a-fresh-new-uuid",
            diagnosis_date: Time.parse("2014-03-01"),
            earliest_start_date: Time.parse("2014-03-04"),
            latest_start_date: Time.parse("2014-03-10"),
            tplan_id: "bae04d10-66fb-0131-38cb-3c07545ed162",
            patient: Tuple(
              first_name: "John",
              last_name: "Doe",
              gender: "M"
            )
          )
        }

        before do
          subject
        end

        it 'should work correctly and insert it' do
          @connection.relvar{
            restrict(base.treatments, treatment_id: "a-fresh-new-uuid")
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
