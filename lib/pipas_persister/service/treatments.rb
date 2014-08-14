module PipasPersister
  module Service
    class Treatments < Base

      get '/:uuid' do |uuid|
        respond_with tuple_extract{
          restrict(service.treatments, treatment_id: uuid)
        }
      end

      post '/' do
        # generate an identifier
        uuid = UUID_GENERATOR.generate

        # decode the input
        input = request.body.read
        input = ::JSON.load(input)
        input = input.merge("treatment_id" => uuid)

        # execute the operation
        r = Resource['/treatments/post'].decode(input)
        run_operation Operation::AddTreatment, r

        # set the header
        headers 'Location' => "/treatments/#{uuid}"

        201
      end

      get '/:uuid/unavailabilities' do |uuid|
        respond_with relvar {
          restrict(base.patient_unavailabilities, treatment_id: uuid)
        }
      end

      put '/:uuid/unavailabilities' do |uuid|
        input = request.body.read
        input = ::JSON.load(input)
        input = input.merge("treatment_id" => uuid)
        r = Resource['/treatments/unavailabilities/put'].decode(input)
        run_operation Operation::AddUnavailability, r
        200
      end

    end # class Treatments
  end # module Service
end # module PipasPersister
