module PipasPersister
  module Service
    class Shield < Rack::Robustness

      # Let other errors go up
      self.no_catch_all

      # Defaults body to the error message
      self.body{|ex| ex.message }

      # Default content-type to 'text/plain'
      self.content_type 'text/plain'

      # Parsing error? -> Bad Request
      self.on(::JSON::ParserError, 400)

      # Precondition Failed? -> Precondition Failed
      self.on(Operation::PreconditionFailed, 412)

      # ResourceTypeError? -> Unprocessable Entity
      self.on(ResourceTypeError, 422)

      # Sequel::ConstraintViolation -> Conflict
      self.on(Sequel::ConstraintViolation, 409)

      # Puts error on standard error
      self.ensure(true) do |ex|
        $stderr.puts ex.class.name
        $stderr.puts ex.message
      end

    end # class Shield
  end # module Service
end # module PipasPersister
