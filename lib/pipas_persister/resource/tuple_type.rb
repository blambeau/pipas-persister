module PipasPersister
  class Resource
    class TupleType < Type

      def self.[](hash)
        coercers = {}
        hash.each_pair do |k,v|
          coercers[Alf::AttrName.coerce(k)] = Type.compile(v)
        end
        new(coercers)
      end

      def initialize(coercers)
        @coercers = coercers
      end
      attr_reader :coercers

      def decode(arg, location = nil)
        type_error("Invalid tuple '#{arg}'", location) unless arg.is_a?(Hash)
        tuple = {}
        coercers.each_pair do |name,coercer|
          value = fetch_hash_value(arg, name, location)
          tuple[name] = coercer.decode(value, child_location(location, name))
        end
        ruby_type.new(tuple)
      end

      def ruby_type
        @ruby_type ||= Tuple[Hash[coercers.map{|k,v| [k, v.ruby_type] }]]
      end

    private

      def fetch_hash_value(hash, name, location)
        hash.fetch(name) do
          hash.fetch(name.to_s) do
            type_error("Missing `#{name}` attribute", location)
          end
        end
      end

    end # class TupleType
  end # class Resource
end # module PipasPersister
