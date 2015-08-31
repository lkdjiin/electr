require 'spec_helper'

include Electr

describe Evaluator do

  CODES_TO_EVAL = [
    {code: "2", result: 2},
    {code: "2 3", result: 6},
    {code: "2 pi", result: 2 * Math::PI},
    {code: "2 + 3", result: 5},
    {code: "2 - 3", result: -1},
    {code: "3 / 2", result: 1.5},
    {code: "2 11k", result: 22_000},
    {code: "sqrt(49)", result: 7},
  ]

  specify "#evaluate_pn" do
    CODES_TO_EVAL.each do |code|
      compiler = Compiler.new
      pns = compiler.compile_to_pn(code[:code])

      evaluator = Evaluator.new
      result = evaluator.evaluate_pn(pns)

      expect(result).to eq code[:result]
    end
  end

  specify do
    compiler = Compiler.new
    pns = compiler.compile_to_pn("1 - 1 + 4 - 1 - 1")
    
    evaluator = Evaluator.new
    result = evaluator.evaluate_pn(pns)

    expect(result).to eq 2
  end



end
