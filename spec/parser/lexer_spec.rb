require 'spec_helper'

include Electr

describe Lexer do

  TOKENS = [
    [ :numeric, "123" ],
    [ :numeric, "0.6" ],
    [ :numeric, ".6" ],
    [ :numeric, "-.6" ],
    [ :numeric, "-0.6" ],
    [ :numeric, "-123" ],
    [ :operator, "+" ],
    [ :operator, "-" ],
    [ :operator, "/" ],
    [ :operator, UNARY_MINUS_INTERNAL_SYMBOL ],
    [ :constant, "pi" ],
    [ :value, "11K" ],
    [ :value, "1A" ],
    [ :value, "1mA" ],
    [ :value, "1 A" ],
    [ :value, "1 mA" ],
    [ :value, "11kΩ" ],
    [ :name, "foobar" ],
    [ :fname, "sqrt" ],
    [ :open_parenthesis, "(" ],
    [ :closed_parenthesis, ")" ],
    [ :assign, "=" ],
    [ :variable, "R1" ],
  ]

  it "lexify" do
    TOKENS.each do |token|
      lexeme = Lexer.lexify(token.last)
      expect(lexeme.type).to eq token.first
      expect(lexeme.value).to eq token.last
    end
  end

  describe "value" do

    it "rejects unknown units" do
      expect { Lexer.lexify("1P") }.to raise_error(Electr::SyntaxError)
      expect { Lexer.lexify("1Q") }.to raise_error(Electr::SyntaxError)
      expect { Lexer.lexify("1X") }.to raise_error(Electr::SyntaxError)
    end

    it "rejects unknown prefixes" do
      expect { Lexer.lexify("1bA") }.to raise_error(Electr::SyntaxError)
      expect { Lexer.lexify("1wW") }.to raise_error(Electr::SyntaxError)
      expect { Lexer.lexify("1jHz") }.to raise_error(Electr::SyntaxError)
    end

    it "accepts known units" do
      expect { Lexer.lexify("1A") }.not_to raise_error
      expect { Lexer.lexify("1 A") }.not_to raise_error
    end

    it "accepts known prefixes" do
      expect { Lexer.lexify("1mA") }.not_to raise_error
      expect { Lexer.lexify("1 mA") }.not_to raise_error
    end

  end

end
