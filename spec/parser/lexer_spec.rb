require 'spec_helper'

include Electr

describe Lexer do

  TOKENS = [
    [ :numeric, "123" ],
    [ :numeric, "0.6" ],
    [ :operator, "+" ],
    [ :constant, "pi" ],
    [ :value, "11K" ],
    [ :value, "11kΩ" ],
    [ :name, "foobar" ],
    [ :fname, "sqrt" ],
    [ :open_parenthesis, "(" ],
    [ :closed_parenthesis, ")" ],
  ]

  it "lexify" do
    TOKENS.each do |token|
      lexeme = Lexer.lexify(token.last)
      expect(lexeme.type).to eq token.first
      expect(lexeme.value).to eq token.last
    end
  end

end
