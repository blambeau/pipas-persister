module PipasPersister
  class Operation
    class UpdateAppointment < Operation

      def execute(input)
        # update the appointment
        relvar{
          restrict(base.appointments, appointment_id: input[:appointment_id])
        }.update appointment_tuple(input)

        # now touch the problem_key and last_modified flag
        relvar{
          base.scheduling
        }.update(last_modified: Time.now, problem_key: new_problem_key)
      end

    private

      def appointment_tuple(input)
        input
      end

      def new_problem_key
        UUID_GENERATOR.generate
      end

    end # class UpdateAppointment
  end # class Operation
end # module PipasPersister
