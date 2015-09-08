require 'spec_helper'

include Electr

describe Compiler do

  CODES_TO_COMPILE = [
    "21 + 3",
    "2",
    "2 pi",
    "2 11K",
    "sqrt(49) + 1",
    "sqrt(49)",
    "1 + sqrt(49)",
    "3 / (2 + 1)",
    "sqrt(40 + 9)",
    "3 (2 + 1)",
    "2 sqrt(3)",
    "2 pi 0.5uF sqrt(11K 22K)",
  ]

  specify "#compile_to_ast" do
    CODES_TO_COMPILE.each do |code|
      result = Compiler.compile_to_ast(code)
      expect(result).to be_a AST
    end
  end

  specify "#compile_to_pn" do
    result = Compiler.compile_to_pn("2 pi")
    expect(result).to be_a Array
  end

  describe "Bug in the AST with `sin(pi / 2) + 1`" do

    # I want the AST as follow:
    #
    # $ electr --ast -e "sin(2) + 1"
    # ast
    #   root
    #     operator (+)
    #       func
    #         funcname ::= sin
    #         funcargs
    #           numeric ::= 2
    #       numeric ::= 1
    #
    # and not as follow (this is the bug result):
    #
    # $ electr --ast -e "sin(2) + 1"
    # ast
    #   root
    #     operator (+)
    #       func
    #         funcname ::= sin
    #         funcargs
    #           numeric ::= 2
    #           numeric ::= 1
    specify "sin(pi / 2) + 1" do
      result = Compiler.compile_to_ast("sin(pi / 2) + 1")
      operator = result.children[0].children[0]
      expect(operator.size).to eq 2
      funcargs = operator.children[0].children[1]
      expect(funcargs.size).to eq 1
    end

  end

end
