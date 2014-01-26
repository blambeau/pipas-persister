module PipasPersister
  module Service
    class Patients < Base
      include Alf::Rack::Helpers

      get '/' do
        relvar_response {
          base.patients
        }
      end

    end # class Patients
  end # module Service
end # module PipasPersister
