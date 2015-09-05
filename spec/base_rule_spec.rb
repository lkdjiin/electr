require 'spec_helper'

include Electr

describe BaseRule do

  it "is not implemented" do
    expect {
      BaseRule.new(nil, nil).apply
    }.to raise_error(NotImplementedError)
  end

end
