module PipasPersister
  class Operation
    class AddUnavailability < Operation

      def execute(input)
        # insert the unavailability
        relvar{
          base.patient_unavailabilities
        }.insert unavailability_tuple(input)

        # now touch the scheduling problem
        touch_scheduling_problem
      end

    private

      def unavailability_tuple(input)
        input
      end

    end # class AddUnavailability
  end # class Operation
end # module PipasPersister
