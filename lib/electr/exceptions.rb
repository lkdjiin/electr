module Electr

  # The good old syntax error ;)
  class SyntaxError < StandardError
  end

  class UnboundVariableError < StandardError
  end

  class NilEvaluationError < StandardError
  end

end
