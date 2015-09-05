require 'spec_helper'
require 'ostruct'

include Electr

class TestReader
  def run
    [
      OpenStruct.new(value: '+', name: 'operator'),
      OpenStruct.new(value: 1, name: 'numeric'),
      OpenStruct.new(value: 2, name: 'numeric')
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
