module PipasPersister
  module Service
    class Appointments < Base

      get '/:uuid' do |uuid|
        respond_with tuple_extract{
          from_plan = project(base.delivery_steps, [:step_id, :bed_load])
          from_plan = rename(from_plan, :bed_load => :duration)
          appoints  = restrict(base.appointments, appointment_id: uuid)
          allbut(join(appoints, from_plan), [:treatment_id, :step_id])
        }
      end

      put '/:uuid' do |uuid|
        input = request.body.read
        input = ::JSON.load(input)
        input = input.merge("appointment_id" => uuid)
        r = Resource['/appointments/singular'].decode(input)
        run_operation Operation::UpdateAppointment, r
        200
      end

    end # class Appointments
  end # module Service
end # module PipasPersister
