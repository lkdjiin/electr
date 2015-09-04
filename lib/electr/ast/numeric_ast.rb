module Electr

  # A node in the AST to represent a numeric, ie 234 or 17.89
  class NumericAST < AST

    def initialize(value)
      super("numeric")
      @value = value
    end

  end
end


