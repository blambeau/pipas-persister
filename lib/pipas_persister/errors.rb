module PipasPersister

  class Error < StandardError

    def initialize(msg, cause = nil)
      super(msg)
      @cause = cause
    end
    attr_reader :cause

  end # class Error

  class NoSuchResourceError < Error; end
  class ResourceTypeError < Error; end
  class NoSuchTypeError < Error; end
end # module PipasPersister
