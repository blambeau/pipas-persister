module PipasPersister
  class Operation
    class UpdateUnavailabilities < Operation

      def execute(input)
        # update unavailabilities
        relvar{
          restrict(base.patient_unavailabilities, treatment_id: input[:treatment_id])
        }.update Tuple(input)

        # now touch the scheduling problem
        touch_scheduling_problem
      end

    end # class UpdateUnavailabilities
  end # class Operation
end # module PipasPersister
