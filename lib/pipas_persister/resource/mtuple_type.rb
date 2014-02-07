module PipasPersister
  class Resource
    class MTupleType < Type
      include HashBasedType

      def decode(arg, location = nil)
        decode_hash(arg, location)
      end

      def ruby_type
        Hash
      end

    end # class MTupleType
  end # class Resource
end # module PipasPersister
