module PipasPersister
  class Operation
    class UpdateSchedulingOperation < Operation

      precondition "non obsolete problem" do |input|
        not relvar{
          restrict(base.scheduling, problem_key: input.problem_key)
        }.empty?
      end

      def execute(input)
        relvar{
          base.appointments
        }.affect appointment_tuples(input)
      end

    private

      def appointment_tuples(input)
        input.treatments
             .ungroup(:appointments)
             .allbut([:rdi])
             .extend(
          appointment_id: ->(t){ PipasPersister::UUID_GENERATOR.generate })
      end

    end # class AddTreatment
  end # class Operation
end # module PipasPersister