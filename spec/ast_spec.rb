require 'spec_helper'

include Electr

describe AST do
  describe AST::Pn do
    describe '#to_f' do
      it { expect(AST::Pn.new('1000', 'n').to_f).to eq 1000.0 }
      it { expect(AST::Pn.new('1_000', 'n').to_f).to eq 1000.0 }
      it { expect(AST::Pn.new('1,000', 'n').to_f).to eq 1000.0 }
    end
  end
end
