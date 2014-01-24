module PipasPersister
  module Viewpoint
    module Top
      include Alf::Viewpoint

      native :protocol_timestamps

      depends :base, Base
      depends :scheduler, Scheduler
      depends :random, Random

    end # module Top
  end # module Viewpoint
end # module PipasPersister
