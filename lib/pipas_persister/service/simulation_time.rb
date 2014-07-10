module PipasPersister
  module Service
    class SimulationTime < Base

      put '/next-day' do
        PipasPersister::nextDay
        200
      end

      put '/next-sec' do
        PipasPersister::nextSecond
        200
      end

    end # class SimulationTime
  end # module Service
end # module PipasPersister
