module Electr

  # A node in the AST to hold an operator, ie +, -, etc.
  class OperatorAST < AST

    def initialize(value)
      super("operator")
      @value = value
    end

  end
end


