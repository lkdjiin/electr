module Electr

  module EvalFunction

    def self.eval(function_name, stack)
      case function_name
      when "sqrt"
        a = stack.pop
        stack.push(Math::sqrt(a))
      when "sin"
        a = stack.pop
        stack.push(Math::sin(a))
      when "cos"
        a = stack.pop
        stack.push(Math::cos(a))
      when "tan"
        a = stack.pop
        stack.push(Math::tan(a))
      end
    end

  end
end
