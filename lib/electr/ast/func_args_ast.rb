module Electr

  # A node in the AST to hold arguments of a function.
  class FuncArgsAST < AST

    def initialize
      super("funcargs")
    end

  end
end

