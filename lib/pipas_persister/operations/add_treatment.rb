module PipasPersister
  class Operation
    class AddTreatment < Operation

      def execute(input)
        # insert the patient
        patient = patient_tuple(input)
        relvar{
          base.patients
        }.insert patient

        # insert the treatment
        relvar{
          base.treatments
        }.insert treatment_tuple(input, patient)

        # now touch the scheduling problem
        touch_scheduling_problem
      end

    private

      def patient_tuple(input)
        input.patient.extend(patient_id: UUID_GENERATOR.generate)
      end

      def treatment_tuple(input, patient)
        input.allbut(:patient).extend(patient_id: patient.patient_id)
      end

    end # class AddTreatment
  end # class Operation
end # module PipasPersister
