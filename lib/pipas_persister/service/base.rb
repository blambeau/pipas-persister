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

      def respond_with(body)
        Alf::Rack::Response.new(env){|r|
          r.body = body
        }.finish
      end

      def compute_etag(*args)
        etag = args.map{|s| s.is_a?(Time) ? s.iso8601(6) : s.to_s }.join(" - ")
        etag = Digest::SHA1.hexdigest(etag)
        etag
      end

    end # class Facade
  end # module Service
end # module PipasPersister
