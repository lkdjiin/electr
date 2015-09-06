require 'spec_helper'

include Electr

describe Printer do

  describe ".run" do

    it 'truncates integer like number' do
      expect { Printer.run(10.0) }.to output("10\n").to_stdout
    end

    it 'rounds number' do
      expect { Printer.run(1.0 / 3) }.to output("0.3333333333\n").to_stdout
    end

  end

end
