require 'spec_helper'
module PipasPersister
  class Operation
    describe UpdateSchedulingSolution do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/update-scheduling-solution')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        UpdateSchedulingSolution.new(@connection).call(input)
      }

      context 'when the problem key is obsolete' do
        let(:input){
          Tuple(problem_key: "foo")
        }

        it 'should raise an error' do
          lambda{
            subject
          }.should raise_error(PreconditionFailed, /obsolete problem/)
        end
      end

      context 'when the problem key is not obsolete' do
        let(:input){
          Tuple(
            problem_key: "update-scheduling-solution",
            treatments: Relation([
              {
                treatment_id: "d9027510-66ff-0131-38cb-3c07545ed162",
                appointments: Relation([
                  {
                    step_id: "74685ae0-66fd-0131-38cb-3c07545ed162",
                    scheduled_at: Time.parse("2014-01-25 09:00:00")
                  },
                  {
                    step_id: "74685c90-66fd-0131-38cb-3c07545ed162",
                    scheduled_at: Time.parse("2014-02-25 15:00:00")
                  }
                ])
              }
            ]),
            service: Relation(
              {
                bed_load: 0.0,
                nurse_load: 0.0
              }
            )
          )
        }

        let(:expected_after){
          Relation([
            {
              step_id: "74685ae0-66fd-0131-38cb-3c07545ed162",
              fixed: true,
              scheduled_at: Time.parse("2014-01-25 09:00:00")
            },
            {
              step_id: "74685c90-66fd-0131-38cb-3c07545ed162",
              fixed: false,
              scheduled_at: Time.parse("2014-02-25 15:00:00")
            }
          ])
        }

        it 'should set the new appointments' do
          subject
          @connection.query{
            project(
              restrict(base.appointments,
                treatment_id: "d9027510-66ff-0131-38cb-3c07545ed162"),
              [:step_id, :fixed, :scheduled_at])
          }.should eq(expected_after)
        end
      end

    end
  end
end
