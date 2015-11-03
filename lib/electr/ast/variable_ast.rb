module Electr

  # A node in the AST to represent a variable.
  class VariableAST < AST

    def initialize(value)
      super("variable")
      @value = value
    end

  end
end

