module Electr

  # Evaluate (compute) a value.
  class Evaluator

    def initialize
      @stack = []
      @environment = {}
    end

    # The environment is where we record the variable's names and
    # values.
    #
    # Useful for testing purposes, for now there is no other needs to
    # expose this variable.
    attr_reader :environment

    def evaluate_pn(list)

      while item = list.pop

        case item.name
        when "numeric"  then @stack.push(item.to_f)
        when "variable" then @stack.push(item.value)
        when "constant" then @stack.push(constant(item.value))
        when "value"    then do_value(item.value)
        when "operator" then operation(item.value)
        when "funcname" then EvalFunction.eval(item.value, @stack)
        end
      end

      ensure_number(@stack.pop)
    end

    private

    # In case we got the name of a variable, replace it by its value.
    def ensure_number(val_or_var)
      if val_or_var.is_a?(String)
        @environment[val_or_var]
      else
        val_or_var
      end
    end

    def constant(value)
      case value
      when "pi" then Math::PI
      end
    end

    def operation(operand)
      case operand
      when UNARY_MINUS_INTERNAL_SYMBOL then unary_minus
      when "=" then assign
      else
        classic_operation(operand)
      end
    end

    def assign
      variable = @stack.pop
      value = ensure_number(@stack.pop)
      @environment[variable] = value
    end

    def unary_minus
      a = @stack.pop
      @stack.push(-a)
    end

    def classic_operation(operand)

      # Use the native ruby operand for exponentiation.
      operand = "**" if operand == '^'

      a = ensure_number(@stack.pop)
      b = ensure_number(@stack.pop)

      @stack.push(a.send(operand, b))
    end

    def do_value(str)
      # FIXME It's going to be better to separate the check for the unit
      # (ohm, volt, ampere, etc) and for the prefix ([m]illi, [k]ilo,
      # etc).
      val = str.to_f

      if %w( k K ).include?(str[-1]) || %w( kΩ ).include?(str[-2..-1])
        val *= 1_000

      elsif %w( mA mV mW ).include?(str[-2..-1])
        val *= 0.001

      elsif %w( u μ ).include?(str[-1]) || %w( μF uF ).include?(str[-2..-1])
        val *= 0.000_001

      elsif str[-1] == 'p' || str[-2..-1] == 'pF'
        val *= 0.000_000_001
      end

      @stack.push(val)
    end

  end

end
