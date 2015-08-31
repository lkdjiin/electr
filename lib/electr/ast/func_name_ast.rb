module Electr

  class FuncNameAST < AST

    def initialize(value)
      super("funcname")
      @value = value
    end

  end
end



