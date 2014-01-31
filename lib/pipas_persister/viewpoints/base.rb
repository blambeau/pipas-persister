module PipasPersister
  module Viewpoint
    module Base
      include Alf::Viewpoint

      native :scheduling

      ### patients

      native :patients

      ### treatment plans

      native :treatment_plans
      native :rest_steps
      native :delivery_steps

      def treatment_plan_steps
        union(
          extend(rest_steps,
            kind: "rest",
            nurse_load: 0,                  # rest steps do not consume nurse minutes
            bed_load: 0,                    # rest steps do not consume bed minutes
            reference_dose: 0.0),           # rest steps do not deliver dosage
          extend(delivery_steps,
            kind: "delivery",
            duration: ->(t){ t.bed_load })  # delivery steps take as many minutes as bed load
        )
      end

      def treatment_plan_derived_attrs
        summarize(treatment_plan_steps, [:tplan_id],
          duration:        sum(:duration),
          reference_dose:  sum(:reference_dose)
        )
      end

      ### treatments

      native :treatments
      native :prescriptions
      native :deliveries
      native :appointments
      native :patient_unavailabilities

      def treatment_doses
        doses = union(
          union(
            reference_doses,
            delivery_doses),
          prescription_doses)
        #group(doses, [:kind, :dose], :doses)
      end

      def reference_doses
        from_plan = project(delivery_steps, [:step_id, :reference_dose])
        project(
          extend(
            rename(
              join(appointments, from_plan),
              :reference_dose => :dose),
            kind: "reference"),
          [:treatment_id, :step_id, :kind, :dose])
      end

      def delivery_doses
        project(
          extend(
            rename(deliveries, :delivered_dose => :dose),
            kind: "delivered"),
          [:treatment_id, :step_id, :kind, :dose])
      end

      def prescription_doses
        from_plan = project(delivery_steps, [:step_id, :reference_dose])
        project(
          extend(
            join(prescriptions, from_plan),
            kind: "prescribed",
            dose: ->(t){ t.reference_dose * (1.0 - t.dose_reduction) }),
          [:treatment_id, :step_id, :kind, :dose])
      end

      ### service & availabilities

      native :bed_availabilities
      native :nurse_availabilities
      native :minutes_per_day

    end # module Base
  end # module Viewpoint
end # module PipasPersister
