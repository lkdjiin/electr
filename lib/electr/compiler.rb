module Electr

  # The toolchain that takes a code at input and outputs it in another
  # structure.
  #
  # The compiler could outputs the code either as an AST or as a list of
  # element in the prefix notation.
  class Compiler

    def self.compile_to_ast(code)
      units = []
      tokenizer = Tokenizer.new(code)
      while tokenizer.has_more_token?
        units << Lexer.lexify(tokenizer.next_token)
      end

      syntaxer = Syntaxer.new(units.dup)
      syntaxer.run
    end

    # To Prefix Notation.
    def self.compile_to_pn(code)
      ast = self.compile_to_ast(code)
      ast.to_pn
    end

  end
end
