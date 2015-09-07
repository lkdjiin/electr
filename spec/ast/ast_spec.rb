require 'spec_helper'

include Electr

describe AST do

  it 'has a name' do
    node = AST.new('foobar')
    expect(node.name).to eq 'foobar'
  end

  it 'has a default name' do
    node = AST.new(nil)
    expect(node.name).to eq 'AST'
  end

end
