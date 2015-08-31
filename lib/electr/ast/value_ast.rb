module Electr

  class ValueAST < AST

    def initialize(value)
      super("value")
      @value = value
    end

  end
end

