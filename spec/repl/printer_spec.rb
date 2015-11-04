require 'spec_helper'

include Electr

describe Printer do

  describe ".run" do

    it 'accepts ElectrValue objects' do
      expect {

        Printer.run(ElectrValue.new(10.0))

      }.not_to raise_error
    end

    it 'accepts only ElectrValue objects' do
      expect {

        Printer.run(10.0)

      }.to raise_error
    end

    it 'truncates integer like number' do
      expect {

        Printer.run(ElectrValue.new(10.0))

      }.to output("10\n").to_stdout
    end

    it 'rounds number' do
      expect {

        Printer.run(ElectrValue.new(1.0 / 3))

      }.to output("0.3333333333\n").to_stdout
    end

    it 'display the error message if any' do
      expect {

        Printer.run(ElectrValue.error("foo"))

      }.to output("foo\n").to_stdout
    end

    it "doesn't display a hidden value" do
      expect {

        Printer.run(ElectrValue.hidden(10))

      }.to_not output.to_stdout
    end

  end

end
