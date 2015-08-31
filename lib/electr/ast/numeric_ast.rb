module Electr

  class NumericAST < AST

    def initialize(value)
      super("numeric")
      @value = value
    end

  end
end


