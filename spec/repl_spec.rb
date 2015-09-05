require 'spec_helper'

include Electr

class TestReader
  def run
    [
      AST::Pn.new('+', 'operator'),
      AST::Pn.new('1', 'numeric'),
      AST::Pn.new('2', 'numeric')
    ]
  end
end

class TestPrinter
  def self.run(arg)
    arg
  end
end

describe Repl do

  describe "#run" do

    it 'runs the toolchain' do
      repl = Repl.new(TestReader.new, Evaluator.new, TestPrinter)
      expect(repl.run_once).to eq 3
    end

  end

end
