module PipasPersister
  module Service
    class Scheduling < Base
      include Alf::Rack::Helpers

      get '/problem' do
        tuple = tuple_extract{ scheduling.identity }

        # Set the HTTP ETag
        etag compute_etag(tuple.problem_key, tuple.last_modified)

        # Set the Last-Modified header
        last_modified tuple.last_modified

        # Return the current scheduling problem
        respond_with tuple_extract{
          scheduling.problems
        }
      end

    end # class Scheduling
  end # module Service
end # module PipasPersister
