module PipasPersister
  class Resource
    class RelationType < Type

      def self.[](array)
        new(Type.compile(array.first))
      end

      def initialize(coercer)
        @coercer = coercer
      end
      attr_reader :coercer

      def decode(arg, location = nil)
        type_error("Invalid relation '#{arg}'", location) unless arg.is_a?(Array)
        tuples = Set.new
        arg.each_with_index do |tuple, i|
          tuples << coercer.decode(tuple, child_location(location, i))
        end
        ruby_type.new(tuples)
      end

      def ruby_type
        @ruby_type ||= Relation[coercer.ruby_type]
      end

    end # class RelationType
  end # class Resource
end # module PipasPersister
