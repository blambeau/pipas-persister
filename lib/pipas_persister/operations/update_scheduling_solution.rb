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

        # Then set the service load
        relvar{
          service.load
        }.affect service_load(input)

        # now touch the last_scheduled flag
        relvar{
          base.scheduling
        }.update(last_scheduled: PipasPersister::getSimulationTime)
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

      def service_load(input)
#        puts input
        proj = input.project([:problem_key, :service])
#        puts proj
        extended = proj.extend(service: ->(t){Relation(t.service)})
#        puts extended
        proj_rel = Relation(extended)
#        puts proj_rel
        ungroup_rel = proj_rel.ungroup(:service)
#        puts ungroup_rel
        service_load_tuple = ungroup_rel.tuple_extract
#        puts service_load_tuple
        service_load_tuple
      end

      def get_old_fixed
        query{
          project(base.appointments, [:treatment_id, :step_id, :fixed])
        }.to_hash([:treatment_id, :step_id] => :fixed)
      end

    end # class UpdateSchedulingSolution
  end # class Operation
end # module PipasPersister
