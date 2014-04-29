module PipasPersister
  module Service
    class Testing < Base

      put '/database' do
        dataset = params['dataset']
        Seeder.call(dataset)
        [ 200,
          {"Content-Type" => "text/plain"},
          ["Dataset `#{dataset}` installed successfully.\n"] ]
      end

    end # class Testing
  end # module Service
end # module PipasPersister
