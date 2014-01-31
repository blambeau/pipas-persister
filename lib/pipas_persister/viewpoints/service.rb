module PipasPersister
  module Viewpoint
    module Service
      include Alf::Viewpoint

      depends :base, Base

      def planning
        extend(
          allbut(base.scheduling, [:problem_key]),
          current_time: Time.now,
          treatments: ->(t){ treatments })
      end

    #private

      def treatments
        ts = allbut(base.treatments, [:earliest_start_date, :latest_start_date])
        ts = detail(ts, patients, :patient)
        ts = detail(ts, treatment_plans, :treatment_plan)
        ts = image(ts, appointments, :appointments)
      end

      def appointments
        from_plan = project(base.delivery_steps, [:step_id, :bed_load])
        from_plan = rename(from_plan, :bed_load => :duration)
        aps = allbut(base.appointments, [:appointment_id])
        aps = join(aps, from_plan)
        aps = image(aps, base.treatment_doses, :doses)
        extend(aps,
          doses: ->(t){ t.doses.to_hash(:kind => :dose) })
      end

      def treatment_plans
        ts = allbut(base.treatment_plans, [:link])
        ts = join(ts, base.treatment_plan_derived_attrs)
      end

      def patients
        base.patients
      end

    end # module Service
  end # module Viewpoint
end # module PipasPersister