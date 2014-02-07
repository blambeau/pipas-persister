module PipasPersister
  module Service
    class Patients < Base

      get '/' do
        respond_with relvar{
          base.patients
        }
      end

    end # class Patients
  end # module Service
end # module PipasPersister
