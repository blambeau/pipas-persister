module PipasPersister
  module Service
    class Patients < Base
      include Alf::Rack::Helpers

      get '/' do
        respond_with relvar{
          base.patients
        }
      end

    end # class Patients
  end # module Service
end # module PipasPersister
