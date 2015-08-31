module Electr

  class ConstantAST < AST

    def initialize(value)
      super("constant")
      @value = value
    end

  end
end



