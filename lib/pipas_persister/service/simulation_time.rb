module PipasPersister
  module Service
    class SimulationTime < Base

      put '/' do
        PipasPersister::updateSimulationTime
        200
      end

    end # class SimulationTime
  end # module Service
end # module PipasPersister
