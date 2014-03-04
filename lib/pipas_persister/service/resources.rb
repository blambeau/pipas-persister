module PipasPersister
  module Service
    class Resources < Base

      get '/', provides: 'text/html' do
        wlang :'resources/list', locals: {
          version: PipasPersister::VERSION,
          resources: resource_list
        }
      end

      get '/', provides: 'application/json' do
        respond_with resource_list
      end

      get '/', provides: 'text/plain' do
        respond_with resource_list
      end

      get %r{^/(.*?)$}, provides: 'text/html' do |uri|
        file     = resource_file(uri)
        resource = file.load
        schema   = file.read[/"schema": (.*?),\n\s+"services":/m, 1]
                       .gsub(/^    /, '')
                       .gsub(/\A\{/, '{          ')
                       .gsub(/\A\[\{/, '[{          ')
        wlang :'resources/detail', locals: resource.merge("rawschema" => schema)
      end

      get %r{^/(.*?)$}, provides: 'text/plain' do |uri|
        resource_file(uri).read
      end

      get %r{^/(.*?)$}, provides: 'application/json' do |uri|
        send_file resource_file(uri)
      end

    private

      def resource_list
        resource_files.map{|f|
          res = f.load
          {
            'uri'      => res["uri"],
            'synopsis' => res["synopsis"],
            'links'    => [
              { 'kind'   => 'example',
                'method' => 'GET',
                'uri'    => "/resources#{res['uri']['example']}" },
              { 'kind'   => 'doc',
                'method' => 'GET',
                'uri'    => "/resources#{res['uri']['documentation']}" }
            ]
          }
        }
      end

      def resource_file(uri)
        uri  = uri[1..-1]  if uri =~ /^\//
        uri  = uri[0...-1] if uri =~ /\/$/
        file = RESOURCES_FOLDER/"#{uri}.json"
        raise Sinatra::NotFound unless file.exists?
        file
      end

      def resource_files(&bl)
        RESOURCES_FOLDER.glob('**/*.json', &bl)
      end

    end # class Resources
  end # module Service
end # module PipasPersister
