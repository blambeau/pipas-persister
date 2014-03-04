module PipasPersister
  module Service
    class TreatmentPlans < Base

      get '/' do
        respond_with relvar{
          service.treatment_plans
        }
      end

    end # class TreatmentPlans
  end # module Service
end # module PipasPersister
