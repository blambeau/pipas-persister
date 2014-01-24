module Alf
  module Algebra
    class Detail
      include Alf::Algebra::Shortcut
      include Alf::Algebra::Unary

      signature do |s|
        s.argument :target, Operand
        s.argument :as,     AttrName
      end

      def expand
        commons  = operand.attr_list & target.attr_list
        renaming = Hash[commons.to_a.map{|x|
          [x, :"detail_#{x}"]
        }]
        extension = Hash[commons.to_a.map{|x|
          [:"detail_#{x}", ->(t){ t[x] }]
        }]
        allbut(
          join(
            rename(operand, renaming),
            wrap(extend(target, extension), renaming.values, as, allbut: true)),
          renaming.values)
      end

    end # class Detail
  end # module Algebra
end # module Alf
