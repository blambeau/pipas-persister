module PipasPersister
  class Operation
    class UpdateSchedulingSolution < Operation

      precondition "non obsolete problem" do |input|
        not relvar{
          restrict(base.scheduling, problem_key: input.problem_key)
        }.empty?
      end

      def execute(input)
        # First set the appointment tuples
        relvar{
          base.appointments
        }.affect appointment_tuples(input)

        # now touch the last_scheduled flag
        relvar{
          base.scheduling
        }.update(last_scheduled: Time.now)
      end

    private

      def appointment_tuples(input)
        old_fixed = get_old_fixed
        input.treatments
             .ungroup(:appointments)
             .allbut([:rdi])
             .extend(
          appointment_id: ->(t){ PipasPersister::UUID_GENERATOR.generate },
          fixed: ->(t){ old_fixed[[t.treatment_id, t.step_id]] || false })
      end

      def get_old_fixed
        query{
          project(base.appointments, [:treatment_id, :step_id, :fixed])
        }.to_hash([:treatment_id, :step_id] => :fixed)
      end

    end # class UpdateSchedulingSolution
  end # class Operation
end # module PipasPersister