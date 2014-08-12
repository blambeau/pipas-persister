module PipasPersister
  module Service
    class Unavailabilities < Base

      get '/:uuid' do |uuid|
        respond_with tuple_extract{
          restrict(base.patient_unavailabilities, treatment_id: uuid)
        }
      end

      put '/:uuid' do |uuid|
        input = request.body.read
        input = ::JSON.load(input)
        input = input.merge("treatment_id" => uuid)
        r = Resource['/unavailabilities/singular'].decode(input)
        run_operation Operation::UpdateUnavailabilities, r
        200
      end

    end # class Unavailabilities
  end # module Service
end # module PipasPersister
