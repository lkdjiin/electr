require 'spec_helper'

include Electr

describe String do
  using Token
  describe '#value?' do
    {
      '1A'   => 0,
      '1mA'  => 0,
      '1 A'  => 0,
      '1 mA' => 0,
      'A'    => nil,
      'A 1'  => nil,
      # The two following use case should probably be included as well.
      # Determining that the string '1Q' is not a value should probably
      # handled at the token level only, to avoid split logic.
      # '1P'   => nil,
      # '1wW'  => nil
    }.each do |input, output|
      it "#{input.inspect}.value? => #{output.inspect}" do
        expect(input.value?).to eq output
      end
    end
  end
end
