require 'spec_helper'

include Electr

describe ASTReader do

  describe ".run" do

    it 'prompts' do
      allow(STDIN).to receive(:gets).and_return("2 3\n")
      reader = ASTReader.new

      expect { reader.run }.to output("E--ast> ").to_stdout
    end

  end

end

