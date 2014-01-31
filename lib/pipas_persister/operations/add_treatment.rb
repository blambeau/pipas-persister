module PipasPersister
  class Operation
    class AddTreatment < Operation

      INPUT_TYPE = {
        patient_id:          String,
        tplan_id:            String,
        diagnosis_date:      Date,
        earliest_start_date: Date,
        latest_start_date:   Date
      }

      def execute(input)
        inserted_tuple(input).tap do |t|
          relvar{
            base.treatments
          }.insert(t)
        end
      end

    private

      def inserted_tuple(input)
        input.extend(
          treatment_id: new_uuid
        )
      end

    end # class AddTreatment
  end # class Operation
end # module PipasPersister