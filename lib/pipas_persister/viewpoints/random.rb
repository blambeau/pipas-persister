module PipasPersister
  module Viewpoint
    module Random
      include Alf::Viewpoint

      expects Base

      def appointments
        uuid = UUID.new
        steps = project(delivery_steps, [:tplan_id, :step_id, :position])
        treat = project(treatments, [:treatment_id, :tplan_id, :patient_id, :earliest_start_date])
        appointments = allbut(join(treat, steps), [:tplan_id])
        appointments = extend(appointments,
          appointment_id: ->(t){
            uuid.generate
          },
          fixed: ->(t){
            t.position == 1
          },
          scheduled_at: ->(t){
            (t.earliest_start_date + (t.position/2)*21).to_time + 9*60*60
          }
        )
        allbut(appointments, [:position, :patient_id, :earliest_start_date])
      end

    end # module Random
  end # module Viewpoint
end # module PipasPersister
