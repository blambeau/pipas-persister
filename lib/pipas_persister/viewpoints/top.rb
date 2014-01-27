module PipasPersister
  module Viewpoint
    module Top
      include Alf::Viewpoint

      depends :base, Base
      depends :scheduling, Scheduling
      depends :random, Random

    end # module Top
  end # module Viewpoint
end # module PipasPersister
