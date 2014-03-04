module PipasPersister
  module Service
    class Deliveries < Base

      get '/:uuid' do |uuid|
        respond_with tuple_extract{
          restrict(base.deliveries, delivery_id: uuid)
        }
      end

      post '/' do
        # generate an identifier
        uuid = UUID_GENERATOR.generate

        # decode the input
        input = request.body.read
        input = ::JSON.load(input)
        input = input.merge("delivery_id" => uuid)

        # execute the operation
        r = Resource['/deliveries/singular'].decode(input)
        run_operation Operation::AddDelivery, r

        # set the header
        headers 'Location' => "/deliveries/#{uuid}"

        201
      end

    end # class Deliveries
  end # module Service
end # module PipasPersister
