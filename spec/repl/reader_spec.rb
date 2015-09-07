require 'spec_helper'

include Electr

class TestReadline
  def self.readline(a, b)
    print a
    "2 3"
  end
end

describe Reader do

  describe ".run" do

    let(:reader) { Reader.new(TestReadline) }

    it 'compiles the expression from STDIN' do
      expect(reader.run.first.name).to eq 'ast'
    end

    it 'prompts' do
      expect { reader.run }.to output("E> ").to_stdout
    end

  end

end
