require 'spec_helper'
require 'ostruct'

include Electr

describe ASTPrinter do

  describe '.run' do

    it 'display ast to STDOUT' do
      ast = Object.new
      def ast.display ; puts 'AST' ; end

      expect { ASTPrinter.run(ast) }.to output("AST\n").to_stdout
    end

  end
end
