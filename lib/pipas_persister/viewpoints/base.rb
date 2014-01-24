module PipasPersister
  module Viewpoint
    module Base
      include Alf::Viewpoint

      native :patients

      native :treatment_plans
      native :rest_steps
      native :delivery_steps

      native :treatments
      native :prescriptions
      native :deliveries
      native :appointments
      native :patient_unavailabilities

      native :bed_availabilities
      native :nurse_availabilities
      native :hours_per_day

    end # module Base
  end # module Viewpoint
end # module PipasPersister
