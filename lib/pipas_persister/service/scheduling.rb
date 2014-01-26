module PipasPersister
  module Service
    class Scheduling < Base
      include Alf::Rack::Helpers

      get '/problem' do
        tuple_response {
          scheduling.problems
        }
      end

    end # class Scheduling
  end # module Service
end # module PipasPersister
