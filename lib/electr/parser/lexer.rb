module Electr

  # Lexical analysis.
  module Lexer

    using Token

    # Public: Build a LexicalUnit from a given token.
    #
    # token - A String token to transform in LexicalUnit.
    #
    # Returns a LexicalUnit.
    def self.lexify(token)
      case token
      when ->(x) { x.numeric? } then LexicalUnit.numeric(token)
      when ->(x) { x.operator? } then LexicalUnit.operator(token)
      when ->(x) { x.constant? } then LexicalUnit.constant(token)
      when ->(x) { x.value? } then LexicalUnit.value(token)
      when ->(x) { x.variable? } then LexicalUnit.variable(token)
      when ->(x) { x == '(' } then LexicalUnit.open_parenthesis
      when ->(x) { x == ')' } then LexicalUnit.closed_parenthesis
      when ->(x) { x == '=' } then LexicalUnit.assign
      when ->(x) { SYMBOL_TABLE[x] == 'f' } then LexicalUnit.fname(token)
      else LexicalUnit.name(token)
      end
    end

  end
end
