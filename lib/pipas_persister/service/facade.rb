module PipasPersister
  module Service
    class Facade < Base

      configure do
        #set :public_folder, PipasPersister::PUBLIC_FOLDER
      end

      get '/' do
        [
          200,
          {'Content-Type' => "text/plain"},
          ["Pipas Persister v#{PipasPersister::VERSION}, (c) UCLouvain, 2014"]
        ]
      end

    end # class Facade
  end # module Service
end # module PipasPersister