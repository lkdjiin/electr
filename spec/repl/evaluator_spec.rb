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
    {code: "11,000 + 22_000", result: 33_000},
    {code: "sin(pi / 2) + 1", result: 2},
    {code: "cos(0) - 1", result: 0},
    {code: "tan(0) - 1", result: -1},
    {code: "10 ^ 2", result: 100},
    {code: "√(49)", result: 7},
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
    pns = Compiler.compile_to_pn("2 * 3")

    evaluator = Evaluator.new
    result = evaluator.evaluate_pn(pns)

    expect(result).to eq 6
  end

  describe "environment" do

    it "don't raise on unbound variable" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1")
      expect {
        evaluator.evaluate_pn(pns)
      }.not_to raise_error
    end

    it "evalutes an assignment" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      result = evaluator.evaluate_pn(pns)

      expect(result).to eq 100.0
    end

    it "retains variable" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      evaluator.evaluate_pn(pns)
      expect(evaluator.environment["R1"]).to eq 100.0
    end

    it "starts empty" do
      evaluator = Evaluator.new
      expect(evaluator.environment.size).to eq 0
    end

    it "assigns an expression" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R2 = 10 + 7")
      evaluator.evaluate_pn(pns)
      expect(evaluator.environment["R2"]).to eq 17.0
    end

    it "assigns a variable's value" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      evaluator.evaluate_pn(pns)

      pns = Compiler.compile_to_pn("R2 = R1")
      evaluator.evaluate_pn(pns)
      expect(evaluator.environment["R2"]).to eq 100.0
    end

    it "gets the value" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      evaluator.evaluate_pn(pns)

      pns = Compiler.compile_to_pn("R1")
      result = evaluator.evaluate_pn(pns)
      expect(result).to eq 100.0

    end

    it "can add two variables" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      evaluator.evaluate_pn(pns)

      pns = Compiler.compile_to_pn("R2 = 200")
      evaluator.evaluate_pn(pns)

      pns = Compiler.compile_to_pn("R1 + R2")
      result = evaluator.evaluate_pn(pns)
      expect(result).to eq 300.0
    end

    it "can add a variable and a numeric" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      evaluator.evaluate_pn(pns)

      pns = Compiler.compile_to_pn("R1 + 50")
      result = evaluator.evaluate_pn(pns)
      expect(result).to eq 150.0
    end

    it "can add a numeric and a variable" do
      evaluator = Evaluator.new

      pns = Compiler.compile_to_pn("R1 = 100")
      evaluator.evaluate_pn(pns)

      pns = Compiler.compile_to_pn("50 + R1")
      result = evaluator.evaluate_pn(pns)
      expect(result).to eq 150.0
    end
  end

end
