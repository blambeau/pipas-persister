module PipasPersister
  class Resource
    class ScalarType < Type

      COERCERS = {
        "float"     => Float,
        "uuid"      => String,
        "timestamp" => Time,
        "string"    => String,
        "date"      => Date,
        "char"      => String,
        "integer"   => Integer,
        "boolean"   => Alf::Boolean
      }

      def self.[](typename)
        coercer = COERCERS[typename]
        raise NoSuchTypeError, "No such type `#{typename}`" unless coercer
        new(typename, coercer)
      end

      def initialize(typename, coercer)
        @typename = typename
        @coercer = coercer
      end
      attr_reader :typename, :coercer

      def decode(arg, location = nil)
        Alf::Support.coerce(arg, coercer)
      rescue TypeError => ex
        type_error("Invalid #{typename} '#{arg}'", location, ex)
      end

      def ruby_type
        coercer
      end

    end # class ScalarType
  end # class Resource
end # module PipasPersister
