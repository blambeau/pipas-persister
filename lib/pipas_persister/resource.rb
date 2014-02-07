require_relative 'resource/type'
require_relative 'resource/scalar_type'
require_relative 'resource/hash_based_type'
require_relative 'resource/tuple_type'
require_relative 'resource/mtuple_type'
require_relative 'resource/relation_type'
module PipasPersister
  class Resource

    # Return a resource instance by identifier
    def self.[](id)
      id   = id[1..-1]  if id =~ /^\//
      id   = id[0...-1] if id =~ /\/$/
      file = RESOURCES_FOLDER/"#{id}.json"
      unless file.exists?
        raise NoSuchResourceError, "No such resource `#{id}`"
      end
      new file.load
    end

    def initialize(definition)
      @definition = definition
    end

    def schema
      @schema ||= Type.compile(@definition['schema'])
    end

    def decode(obj)
      schema.decode(obj)
    end

  end # class Resource
end # module PipasPersister
