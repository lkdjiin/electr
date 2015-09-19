require 'spec_helper'

include Electr

describe LexicalUnit::Value do

  describe "assert" do

    it "rejects unknown units" do
      unknown = %w( 1P 1Q 1X )
      unknown.each do |unit|
        expect {
          LexicalUnit::Value.assert(unit)
        }.to raise_error(Electr::SyntaxError)
      end
    end

    it "asserts valid units" do
      known = %w( 1V 1C 1S )
      known.each do |unit|
        expect { LexicalUnit::Value.assert(unit) }.not_to raise_error
      end
    end

    it "rejects unknown prefixes" do
      unknown = %w( 1xV 1bV 1wW )
      unknown.each do |unit|
        expect {
          LexicalUnit::Value.assert(unit)
        }.to raise_error(Electr::SyntaxError)
      end
    end

    it "accepts valid prefixes" do
      known = %w( 1mV 1μF 1nF )
      known.each do |unit|
        expect { LexicalUnit::Value.assert(unit) }.not_to raise_error
      end
    end

    it "accepts unit abbreviations" do
      abbreviations = %w( 1u 1μ 1n 1p 1k 1K )
      abbreviations.each do |unit|
        expect { LexicalUnit::Value.assert(unit) }.not_to raise_error
      end
    end

  end
end
