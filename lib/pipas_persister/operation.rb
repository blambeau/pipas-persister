module PipasPersister
  class Operation
    extend Forwardable

    PreconditionFailed = Class.new(StandardError)

    def initialize(conn)
      @conn = conn
    end
    attr_reader :conn

    def_delegators :conn, :relvar, :query, :tuple_extract

    class << self

      def preconditions
        @preconditions ||= []
      end

      def precondition(msg, &bl)
        id = :"__precondition_#{preconditions.size}"
        define_method(id, &bl)
        private(id)
        preconditions << [id, msg]
      end

    end # class << self

    def call(input)
      conn.in_transaction do
        check_preconditions!(input)
        execute(input)
      end
    end

  protected

    def execute(input)
    end

    def preconditions
      self.class.preconditions
    end

    def check_preconditions!(input)
      preconditions.each do |(id, msg)|
        raise PreconditionFailed, "Precondition failed: #{msg}" \
          unless send(id, input)
      end
    end

    def touch_scheduling_problem
      relvar{
        base.scheduling
      }.update(last_modified: Time.now, problem_key: new_problem_key)
    end

    def new_problem_key
      UUID_GENERATOR.generate
    end

  end # class Operation
end # module PipasPersister
