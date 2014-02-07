module PipasPersister
  class Resource
    module HashBasedType

      def self.[](hash)
        coercers, mtuple = {}, false
        hash.each_pair do |k,v|
          name, required = nil, nil
          if k =~ /^(.*?)\s+\(\?\)$/
            name, required = $1, false
          else
            name, required = k, true
          end
          mtuple = mtuple || !required
          coercers[Alf::AttrName.coerce(name)] = [required, Type.compile(v)]
        end
        mtuple ? MTupleType.new(coercers) : TupleType.new(coercers)
      end

      def initialize(coercers)
        @coercers = coercers
      end
      attr_reader :coercers

    protected

      def decode_hash(arg, location = nil)
        type_error("Invalid tuple '#{arg}'", location) unless arg.is_a?(Hash)
        tuple = {}
        coercers.each_pair do |name,(required, coercer)|
          fetch_hash_value(arg, name, required){|val, found|
            if required && !found
              type_error("Missing `#{name}` attribute", location)
            elsif found
              tuple[name] = coercer.decode(val, child_location(location, name))
            end
          }
        end
        tuple
      end

      def fetch_hash_value(hash, name, location)
        val = hash.fetch(name) do
          hash.fetch(name.to_s) do
            return yield(nil, false)
          end
        end
        yield(val, true)
      end

    end # class TupleType
  end # class Resource
end # module PipasPersister
