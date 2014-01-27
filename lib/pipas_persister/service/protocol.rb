module PipasPersister
  module Service
    class Protocol
      include Alf::Rack::Helpers

      def initialize(app)
        @app = app
      end
      attr_reader :app

      def call(env)
        app.call(env)
      end

    end # class Schedule
  end # module Service
end # module PipasPersister
