module PipasPersister
  module Service
    class Treatments < Base

      get '/:uuid' do |uuid|
        respond_with tuple_extract{
          restrict(service.treatments, treatment_id: uuid)
        }
      end

    end # class Treatments
  end # module Service
end # module PipasPersister
