module Electr

  # Rules an Electr expression.
  #
  # TODO For now almost everything is an expression in Electr, so this
  # is a somewhat complicated class. It should be refactored a lot.
  class ExpressionRule < BaseRule

    def apply
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

      if number?
        dig_series(@ast_node)
      else
        unit = @series.shift
        # If we want to handle = differently than other operators, we
        # can do something like the following:
        # node_class = unit.assign? ? AssignAST : OperatorAST
        # node = node_class.new(unit.value)
        node = OperatorAST.new(unit.value)
        dig_series(node) while @series.size > 0
        @ast_node.add_child(node)
      end
    end

    private

    def number?
      first = @series.first
      # Is it make sense to say all this things are «numbers»?
      first.numeric? || first.constant? || first.value? || first.fname? ||
        first.variable?
    end

    def first_unit_fname?
      @units.first && @units.first.fname?
    end

    def dig_series(node)
      while unit = @series.shift

        if unit && unit.numeric? && there_is_room?(node)
          node.add_child(NumericAST.new(unit.value))

        elsif unit && unit.constant? && there_is_room?(node)
          node.add_child(ConstantAST.new(unit.value))

        elsif unit && unit.value? && there_is_room?(node)
          node.add_child(ValueAST.new(unit.value))

        elsif unit && unit.fname? && there_is_room?(node)
          func      = FuncAST.new
          func_name = FuncNameAST.new(unit.value)
          func_args = FuncArgsAST.new
          dig_series(func_args)
          func.add_child(func_name)
          func.add_child(func_args)
          node.add_child(func)

        elsif unit && (unit.operator? || unit.assign?)
          new_node = OperatorAST.new(unit.value)
          dig_series(new_node)
          node.add_child(new_node)

        elsif unit && unit.variable?
          node.add_child(VariableAST.new(unit.value))

        else
          @series.unshift(unit)
          break
        end
      end
    end

    def there_is_room?(node)
      case node.name
      when 'funcargs'
        node.size < 1
      else
        (node.value == UNARY_MINUS_INTERNAL_SYMBOL && node.size < 1) ||
        (node.value != UNARY_MINUS_INTERNAL_SYMBOL && node.size < 2)
      end
    end

  end
end
