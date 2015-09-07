require 'spec_helper'

include Electr

class TestReadline
  def self.readline(a, b)
    print a
    "2 3"
  end
end

describe ASTReader do

  describe ".run" do

    it 'prompts' do
      reader = ASTReader.new(TestReadline)

      expect { reader.run }.to output("E--ast> ").to_stdout
    end

  end

end

