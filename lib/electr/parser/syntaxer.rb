module Electr

  # A Syntaxer transform a list of lexical units into an AST.
  class Syntaxer

    # lexical_units - Array of LexicalUnits
    def initialize(lexical_units)
      @units = lexical_units
      @ast = AST.new "ast"
    end

    # Public: Compile lexical units into an AST.
    #
    # Returns the AST.
    def run
      RootRule.new(@units, @ast).apply!
      @ast
    end

  end
end
