module Electr

  # A node in the AST to hold a value, ie 10mA or 3V.
  class ValueAST < AST

    def initialize(value)
      super("value")
      @value = value
    end

  end
end

