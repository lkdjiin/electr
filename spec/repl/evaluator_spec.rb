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
    {code: "3V / 25mA", result: 120},
    {code: "110V / 2A", result: 55},
    {code: "10mV 100R", result: 1},
    {code: "10W 2", result: 20},
    {code: "100mW 2", result: 0.2},
    {code: "1u", result: 0.000_001},
    {code: "1pF", result: 0.000_000_001},
    {code: ".12 .5", result: 0.06},
    {code: "-.12 .5", result: -0.06},
    {code: "-2 -3", result: 6},
    {code: "2 -3V", result: -6},
    {code: "-sqrt(49)", result: -7},
    {code: "-pi", result: -Math::PI},
    {code: "-pi 2", result: -(2 * Math::PI)},
    {code: "2 -pi", result: -(2 * Math::PI)},
    {code: "1 - 1 + 4 - 1 - 1", result: 2},
    {code: "-(2 3)", result: -6},
  ]

  specify "#evaluate_pn" do
    CODES_TO_EVAL.each do |code|
      pns = Compiler.compile_to_pn(code[:code])

      evaluator = Evaluator.new
      result = evaluator.evaluate_pn(pns)

      expect(result).to eq code[:result]
    end
  end

  specify do
    pns = Compiler.compile_to_pn("11,000 + 22_000")
    
    evaluator = Evaluator.new
    result = evaluator.evaluate_pn(pns)

    expect(result).to eq 33_000
  end



end
