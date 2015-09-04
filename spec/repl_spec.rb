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
  def run_ast
    "foobar"
  end
end

class TestPrinter
  def run(arg)
    arg
  end
  alias_method :run_ast, :run
end

describe Repl do

  describe "#run" do
    it 'runs the toolchain' do
      repl = Repl.new(TestReader.new, TestPrinter.new)
      expect(repl.run_once).to eq 3
    end
  end

  describe "#run_ast" do
    it 'runs the toolchain' do
      repl = Repl.new(TestReader.new, TestPrinter.new)
      expect(repl.run_ast_once).to eq 'foobar'
    end
  end
end
