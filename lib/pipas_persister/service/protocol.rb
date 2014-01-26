module PipasPersister
  module Service
    class Protocol
      include Alf::Rack::Helpers

      def initialize(app)
        @app = app
      end
      attr_reader :app, :env

      def call(env)
        dup._call(env)
      end

      def _call(env)
        @env = env
        status, headers, body = nil

        # lock and do the job
        relvar(:protocol_timestamps).lock do
          # delegate to the app
          status, headers, body = app.call(env)

          # extract the accuracy timestamp
          ts = tuple_extract{
            protocol_timestamps
          }
          accuracy_timestamp = ts[:accuracy_timestamp]

          # set the header
          headers['X-Accuracy-Timestamp'] = accuracy_timestamp.iso8601(6)
        end

        # return that response
        [ status, headers, body ]
      end

    end # class Schedule
  end # module Service
end # module PipasPersister
