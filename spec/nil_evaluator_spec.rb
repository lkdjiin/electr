require 'spec_helper'

include Electr

describe NilEvaluator do

  it 'returns the argument untouched' do
    expect(NilEvaluator.new.evaluate_pn('foo')).to eq 'foo'
  end

end
