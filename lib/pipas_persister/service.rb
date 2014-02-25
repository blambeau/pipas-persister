require 'rack'
require 'rack/robustness'
require 'sinatra/base'
require 'alf-rack'

require_relative 'service/base'
require_relative 'service/shield'
require_relative 'service/scheduling'
require_relative 'service/patients'
require_relative 'service/service_info'
require_relative 'service/facade'
require_relative 'service/protocol'
require_relative 'service/resources'
require_relative 'service/testing'
require_relative 'service/cors'

module PipasPersister
  module Service
    INSTANCE = ::Rack::Builder.new do

      # In development mode put the logs on standard output
      use Rack::CommonLogger, STDOUT if PipasPersister::ENVIRONMENT =~ /devel/

      # Set the content-length on every request
      use Rack::ContentLength

      # Convert exceptions to proper HTTP error codes
      use Shield

      # Allow cross-origin requests
      use Cors

      # Connect to the database
      use Alf::Rack::Connect do |cfg|
        cfg.database  = PipasPersister::ALF_DATABASE
        cfg.viewpoint = PipasPersister::Viewpoint::Top[]
      end

      # Implement the lock protocol and accuracy timestamp header
      use Service::Protocol

      map '/resources' do
        run Service::Resources
      end

      map '/scheduling' do
        run Service::Scheduling
      end

      map '/patients' do
        run Service::Patients
      end

      map '/service' do
        run Service::ServiceInfo
      end

      map '/testing' do
        run Service::Testing
      end # if PipasPersister::ENVIRONMENT =~ /devel|test/

      # Run '/' and that kind of 'static' services
      run Service::Facade

    end
  end # module Service
end # module PipasPersister
