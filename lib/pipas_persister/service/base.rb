module PipasPersister
  module Service
    class Base < Sinatra::Base

      configure do
        # Set the environment we run in
        set :environment, PipasPersister::ENVIRONMENT

        # Do raise errors, the Guardian will catch them properly
        enable  :raise_errors

        # Do not dump erros in log
        disable :dump_errors

        # Do not show exceptions on the web interface
        disable :show_exceptions
      end

    private

      def relvar_response(&bl)
        Alf::Rack::Response.new(env){|r|
          r.body = relvar(&bl)
        }.finish
      end

      def tuple_response(&bl)
        Alf::Rack::Response.new(env){|r|
          r.body = tuple_extract(&bl)
        }.finish
      end

    end # class Facade
  end # module Service
end # module PipasPersister
