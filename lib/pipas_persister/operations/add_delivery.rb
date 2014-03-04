module PipasPersister
  class Operation
    class AddDelivery < Operation

      def execute(input)
        # insert the delivery
        relvar{
          base.deliveries
        }.insert delivery_tuple(input)

        # now touch the scheduling problem
        touch_scheduling_problem
      end

    private

      def delivery_tuple(input)
        input
      end

    end # class AddDelivery
  end # class Operation
end # module PipasPersister
