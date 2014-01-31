require 'spec_helper'
module PipasPersister
  class Operation
    describe UpdateSchedulingOperation do

      before do
        @connection = PipasPersister::ALF_DATABASE.connection
        Seeder.new(@connection).call('operation-tests/update-scheduling-solution')
        @connection.reconnect(viewpoint: Viewpoint::Top[])
      end

      after do
        @connection.close
      end

      subject{
        UpdateSchedulingOperation.new(@connection).call(input)
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
        let(:appointments){
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
        let(:input){
          Tuple(
            problem_key: "update-scheduling-solution",
            rdi: 0.95,
            treatments: Relation([
              {
                treatment_id: "d9027510-66ff-0131-38cb-3c07545ed162",
                appointments: appointments
              }
            ])
          )
        }

        it 'should set the new appointments' do
          subject
          @connection.query{
            project(
              restrict(base.appointments,
                treatment_id: "d9027510-66ff-0131-38cb-3c07545ed162"),
              [:step_id, :fixed, :scheduled_at])
          }.should eq(appointments)
        end
      end

    end
  end
end
