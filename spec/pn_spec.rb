require 'spec_helper'

include Electr

describe Pn do

  describe '#to_f' do

    it { expect(Pn.new('1000', 'n').to_f).to eq 1000.0 }

    it { expect(Pn.new('1_000', 'n').to_f).to eq 1000.0 }

    it { expect(Pn.new('1,000', 'n').to_f).to eq 1000.0 }

  end

end
