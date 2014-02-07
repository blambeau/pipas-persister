module PipasPersister
  class Resource
    class Type

      RelDef = ->(t){ t.is_a?(Array) && (t.size == 1) && t.first.is_a?(Hash) }

      def self.compile(defn)
        case defn
        when String then ScalarType[defn]
        when Hash   then TupleType[defn]
        when RelDef then RelationType[defn]
        else
          raise ArgumentError, "Unexpected `#{defn}` in Type.compile"
        end
      end

    protected

      def child_location(parent, child)
        child = "[#{child}]" if child.is_a?(Integer)
        parent.nil? ? child : "#{parent}/#{child}"
      end

      def type_error(msg, location, cause = nil)
        msg = msg + " @ `#{location}`" if location
        raise ResourceTypeError.new(msg, cause)
      end

    end # class Type
  end # class Resource
end # module PipasPersister
