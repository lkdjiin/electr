require 'spec_helper'

include Electr

class TestReader
  def run
    [
      Pn.new('+', 'operator'),
      Pn.new('1', 'numeric'),
      Pn.new('2', 'numeric')
    ]
  end
end

class InputStopTestReader
  def initialize
    @entries = [
      [
        Pn.new('+', 'operator'),
        Pn.new('1', 'numeric'),
        Pn.new('2', 'numeric')
      ],
      nil # end of input
    ]
  end
  def run
    @entries.shift
  end
end

class TestPrinter
  def self.run(arg)
    arg
  end
end

describe Repl do

  describe "#run_once" do

    it 'runs the toolchain' do
      repl = Repl.new(TestReader.new, Evaluator.new, TestPrinter)
      expect(repl.run_once).to eq ElectrValue.number(3)
    end

    it 'runs the toolchain' do
      repl = Repl.new(InputStopTestReader.new, Evaluator.new, TestPrinter)
      expect(repl.run_once).to eq ElectrValue.number(3)
      expect(repl.run_once).to eq false
    end

  end

end
