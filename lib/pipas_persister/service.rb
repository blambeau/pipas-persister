require 'rack'
require 'sinatra/base'
require 'alf-rack'

require_relative 'service/base'
require_relative 'service/schedule'
require_relative 'service/facade'

module PipasPersister
  module Service
    INSTANCE = ::Rack::Builder.new do

      # In development mode put the logs on standard output
      use Rack::CommonLogger, STDOUT if PipasPersister::ENVIRONMENT =~ /devel/

      # Set the content-length on every request
      use Rack::ContentLength

      # Connect to the database
      use Alf::Rack::Connect do |cfg|
        cfg.database  = PipasPersister::ALF_DATABASE
        cfg.viewpoint = PipasPersister::Viewpoint::Top[]
      end

      map '/schedule' do
        run Service::Schedule
      end

      # Run '/' and that kind of 'static' services
      run Service::Facade

    end
  end # module Service
end # module PipasPersister
