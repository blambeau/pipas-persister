module PipasPersister
  module Service
    class Cors

      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, body = @app.call(env)
        if origin=env['HTTP_ORIGIN']
          headers.merge! cors_headers(origin)
        end
        if env['REQUEST_METHOD'] == 'OPTIONS'
          headers['Content-Length'] = '0'
          status, headers, body = [200, headers, []]
        end
        [status, headers, body]
      end

    private

      def cors_headers(origin)
        { 'Access-Control-Allow-Origin'      => origin,
          'Access-Control-Allow-Methods'     => 'OPTIONS, HEAD, GET, POST, PUT, DELETE',
          'Access-Control-Allow-Credentials' => 'true',
          'Access-Control-Max-Age'           => '1728000',
          'Access-Control-Allow-Headers'     => 'Authorization, Content-Type, Origin, Accept, If-Modified-Since, If-Match, If-None-Match',
          'Access-Control-Expose-Headers'    => 'Location, ETag, Last-Modified, Content-Type' }
      end

    end # class Cors
  end # module Service
end # module PipasPersister
