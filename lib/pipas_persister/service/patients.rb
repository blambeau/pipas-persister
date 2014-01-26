module PipasPersister
  module Service
    class Patients < Base
      include Alf::Rack::Helpers

      get '/' do
        Alf::Rack::Response.new{|r|
          r.body = relvar{
            base.patients
          }
        }.finish
      end

    end # class Patients
  end # module Service
end # module PipasPersister
