module PipasPersister
  module Viewpoint
    module Service
      include Alf::Viewpoint

      depends :base, Base

      def planning
        extend(DEE,
          current_time: Time.now,
          treatments: ->(t){ treatments })
      end

      def availabilities
        beds    = rename(base.bed_availabilities, quantity: :beds)
        nurses  = rename(base.nurse_availabilities, quantity: :nurses)
        minutes = rename(base.minutes_per_day, quantity: :minutes)
        avail   = join(join(beds, nurses), minutes)
        allbut(extend(avail, open: ->(t){ t.minutes > 0 }), :minutes)
      end

    #private

      def treatments
        ts = base.treatments
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