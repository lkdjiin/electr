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

  specify do
    result = Compiler.compile_to_ast("-pi 2")
    result.display
    expect(result).to be_a AST
  end

  specify "#compile_to_pn" do
    result = Compiler.compile_to_pn("2 pi")
    expect(result).to be_a Array
  end

end
