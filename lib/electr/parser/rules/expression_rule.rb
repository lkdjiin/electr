module Electr

  class ExpressionRule < BaseRule

    def apply!
      while @units.size > 0
        if first_unit_fname?
          accept(:fname)
          accept(:open_parenthesis, '(')
          while @units.first && (not @units.first.closed_parenthesis?)
            accept(@units.first.type)
          end
          accept(:closed_parenthesis, ')')
        else
          accept(@units.first.type)
        end
      end

      sya = Sya.new(@series.dup)
      @series = sya.run

      if @series.first.numeric? || @series.first.constant? ||
         @series.first.value? || @series.first.fname?
        dig_series(@ast_node)
      else
        unit = @series.shift
        node = OperatorAST.new(unit.value)
        dig_series(node) while @series.size > 0
        @ast_node.add_child(node)
      end
    end

    private

    def first_unit_fname?
      @units.first && @units.first.fname?
    end

    def dig_series(node)
      while unit = @series.shift
        if unit && unit.numeric? && node.size < 2
          node.add_child(NumericAST.new(unit.value))
        elsif unit && unit.constant? && node.size < 2
          node.add_child(ConstantAST.new(unit.value))
        elsif unit && unit.value? && node.size < 2
          node.add_child(ValueAST.new(unit.value))
        elsif unit && unit.fname? && node.size < 2
          func      = FuncAST.new
          func_name = FuncNameAST.new(unit.value)
          func_args = FuncArgsAST.new
          dig_series(func_args)
          func.add_child(func_name)
          func.add_child(func_args)
          node.add_child(func)
        elsif unit && unit.operator?
          new_node = OperatorAST.new(unit.value)
          dig_series(new_node)
          node.add_child(new_node)
        else
          @series.unshift(unit)
          break
        end
      end
    end

  end
end
