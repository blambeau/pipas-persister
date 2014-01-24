module PipasPersister
  module Service
    class Schedule < Base
      include Alf::Rack::Helpers

      get '/' do
        Alf::Rack::Response.new{|r|
          r.body = tuple_extract{
            scheduler.schedule
          }
        }.finish
      end

    end # class Schedule
  end # module Service
end # module PipasPersister
