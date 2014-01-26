module PipasPersister
  module Service
    class Scheduling < Base
      include Alf::Rack::Helpers

      get '/problem' do
        Alf::Rack::Response.new{|r|
          r.body = tuple_extract{
            scheduling.problems
          }
        }.finish
      end

    end # class Scheduling
  end # module Service
end # module PipasPersister
