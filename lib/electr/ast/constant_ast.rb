module Electr

  # A constant node in the AST, ie the number pi.
  class ConstantAST < AST

    def initialize(value)
      super("constant")
      @value = value
    end

  end
end



