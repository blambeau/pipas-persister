require 'rack'
require 'sinatra/base'

require_relative 'service/base'
require_relative 'service/facade'

module PipasPersister
  module Service
    INSTANCE = ::Rack::Builder.new do
    
      run Service::Facade
    end
  end # module Service
end # module PipasPersister
