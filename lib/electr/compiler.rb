module Electr

  class Compiler

    def compile_to_ast(code)
      units = []
      tokenizer = Tokenizer.new(code)
      lexer = Lexer.new
      while tokenizer.has_more_token?
        units << lexer.lexify(tokenizer.next_token)
      end

      syntaxer = Syntaxer.new(units.dup)
      ast = syntaxer.run
    end

    # To Prefix Notation.
    def compile_to_pn(code)
      ast = compile_to_ast(code)
      ast.to_pn
    end

  end
end
