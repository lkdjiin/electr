module Electr

  # Evaluate (compute) a value.
  class Evaluator

    def initialize
      @stack = []
    end

    def evaluate_pn(list)
      while item = list.pop
        case item.name
        when "numeric" then @stack.push(item.value.to_f)
        when "constant" then @stack.push(constant(item.value))
        when "value" then do_value(item.value)
        when "operator" then operation(item.value)
        when "funcname" then func(item.value)
        end
      end

      @stack.pop
    end

    private

    def constant(value)
      case value
      when "pi" then Math::PI
      end
    end

    def func(name)
      case name
      when "sqrt"
        a = @stack.pop
        @stack.push(Math::sqrt(a))
      end
    end

    def operation(operand)
      a = @stack.pop
      b = @stack.pop
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
