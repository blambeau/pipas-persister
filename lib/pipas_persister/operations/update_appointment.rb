module PipasPersister
  class Operation
    class UpdateAppointment < Operation

      def execute(input)
        # update the appointment
        relvar{
          restrict(base.appointments, appointment_id: input[:appointment_id])
        }.update appointment_tuple(input)

        # now touch the scheduling problem
        touch_scheduling_problem
      end

    private

      def appointment_tuple(input)
        Tuple(input).allbut([:duration])
      end

    end # class UpdateAppointment
  end # class Operation
end # module PipasPersister
