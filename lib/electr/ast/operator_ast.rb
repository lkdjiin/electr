module Electr

  class OperatorAST < AST

    def initialize(value)
      super("operator")
      @value = value
    end

  end
end


