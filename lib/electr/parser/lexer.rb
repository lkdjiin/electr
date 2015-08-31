module Electr

  class Lexer

    # Public: Build a LexicalUnit from a given token.
    #
    # token - A String token to transform in LexicalUnit.
    #
    # Returns a LexicalUnit.
    def lexify(token)
      if numeric?(token)
        LexicalUnit.numeric(token)
      elsif operator?(token)
        LexicalUnit.operator(token)
      elsif constant?(token)
        LexicalUnit.constant(token)
      elsif value?(token)
        LexicalUnit.value(token)
      elsif token == '('
        LexicalUnit.open_parenthesis()
      elsif token == ')'
        LexicalUnit.closed_parenthesis()
      elsif SYMBOL_TABLE[token] == 'f'
        LexicalUnit.fname(token)
      else
        LexicalUnit.name(token)
      end
    end

    private

    def numeric?(token)
      token =~ /[0-9.]\Z/
    end

    def operator?(token)
      %w( + - / ).include?(token)
    end

    def constant?(token)
      %w( pi ).include?(token)
    end

    def value?(token)
      # The unit part is redondant with Tokenizer.
      token =~ /[0-9.][kKRuFpΩμ]{1,}\Z/
    end

  end
end
