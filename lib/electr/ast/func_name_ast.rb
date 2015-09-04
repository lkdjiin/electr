module Electr

  # A node in the AST to represent the name of a function, ie sqrt, sin
  # or cos.
  class FuncNameAST < AST

    def initialize(value)
      super("funcname")
      @value = value
    end

  end
end



