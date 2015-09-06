require 'spec_helper'

include Electr

describe Reader do

  describe ".run" do

    before do
      allow(STDIN).to receive(:gets).and_return("2 3\n")
    end

    let(:reader) { Reader.new }

    it 'compiles the expression from STDIN' do
      expect(reader.run.first.name).to eq 'ast'
    end

    it 'prompts' do
      expect { reader.run }.to output("E> ").to_stdout
    end

  end

end
