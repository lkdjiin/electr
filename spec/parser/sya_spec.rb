require 'spec_helper'

include Electr

describe Sya do

  specify '2 + 3' do
    a = LexicalUnit.numeric('2')
    b = LexicalUnit.operator('+')
    c = LexicalUnit.numeric('3')
    sya = Sya.new([a, b, c])

    expect(sya.run).to eq [b, a, c]
  end

  specify '2 3 + 4' do
    a = LexicalUnit.numeric('2')
    b = LexicalUnit.numeric('3')
    c = LexicalUnit.operator('+')
    d = LexicalUnit.numeric('4')
    added = LexicalUnit.operator('*')
    sya = Sya.new([a, b, c, d])

    # + * 2 3 4
    expect(sya.run).to eq [c, added, a, b, d]
  end

  specify '2 + 3 4' do
    a = LexicalUnit.numeric('2')
    b = LexicalUnit.operator('+')
    c = LexicalUnit.numeric('3')
    d = LexicalUnit.numeric('4')
    added = LexicalUnit.operator('*')
    sya = Sya.new([a, b, c, d])

    # + 2 * 3 4
    expect(sya.run).to eq [b, a, added, c, d]
  end

  specify '2 pi' do
    a = LexicalUnit.numeric('2')
    b = LexicalUnit.constant('pi')
    added = LexicalUnit.operator('*')
    sya = Sya.new([a, b])

    # * 2 pi
    expect(sya.run).to eq [added, a, b]
  end

  specify '2 11K' do
    a = LexicalUnit.numeric('2')
    b = LexicalUnit.constant('11K')
    added = LexicalUnit.operator('*')
    sya = Sya.new([a, b])

    # * 2 11K
    expect(sya.run).to eq [added, a, b]
  end

  specify 'sqrt(49) + 1' do
    a = LexicalUnit.fname('sqrt')
    b = LexicalUnit.open_parenthesis
    c = LexicalUnit.numeric('49')
    d = LexicalUnit.closed_parenthesis
    e = LexicalUnit.operator('+')
    f = LexicalUnit.numeric('1')
    sya = Sya.new([a, b, c, d, e, f])

    # + sqrt 49 1
    expect(sya.run).to eq [e, a, c, f]
  end

  specify '1 + sqrt(7)' do
    a = LexicalUnit.numeric('1')
    b = LexicalUnit.operator('+')
    c = LexicalUnit.fname('sqrt')
    d = LexicalUnit.open_parenthesis
    e = LexicalUnit.numeric('7')
    f = LexicalUnit.closed_parenthesis
    sya = Sya.new([a, b, c, d, e, f])

    # + 1 sqrt 7
    expect(sya.run).to eq [b, a, c, e]
  end

  specify '3 / 2 + 1' do
    a = LexicalUnit.numeric('3')
    b = LexicalUnit.operator('/')
    c = LexicalUnit.numeric('2')
    d = LexicalUnit.operator('+')
    e = LexicalUnit.numeric('1')
    sya = Sya.new([a, b, c, d, e])

    # + / 3 2 1
    expect(sya.run).to eq [d, b, a, c, e]
  end

  specify '2 - 3 + 5' do
    a = LexicalUnit.numeric('2')
    b = LexicalUnit.operator('-')
    c = LexicalUnit.numeric('3')
    d = LexicalUnit.operator('+')
    e = LexicalUnit.numeric('5')
    sya = Sya.new([a, b, c, d, e])

    # + - 2 3 5
    expect(sya.run).to eq [d, b, a, c, e]
  end

  specify '1 - 1 + 4 - 1 - 1' do
    a = LexicalUnit.numeric('1')
    b = LexicalUnit.operator('-')
    c = LexicalUnit.numeric('1')
    d = LexicalUnit.operator('+')
    e = LexicalUnit.numeric('4')
    f = LexicalUnit.operator('-')
    g = LexicalUnit.numeric('1')
    h = LexicalUnit.operator('-')
    i = LexicalUnit.numeric('1')
    sya = Sya.new([a, b, c, d, e, f, g, h, i])

    # - - + - 1 1 4 1 1
    expect(sya.run).to eq [b, b, d, b, a, c, e, g, i]
  end

  specify '3 / (2 + 1)' do
    a = LexicalUnit.numeric('3')
    b = LexicalUnit.operator('/')
    c = LexicalUnit.open_parenthesis
    d = LexicalUnit.numeric('2')
    e = LexicalUnit.operator('+')
    f = LexicalUnit.numeric('1')
    g = LexicalUnit.closed_parenthesis
    sya = Sya.new([a, b, c, d, e, f, g])

    # / 3 + 2 1
    expect(sya.run).to eq [b, a, e, d, f]
  end

  specify 'sqrt(40 + 9)' do
    a = LexicalUnit.fname('sqrt')
    b = LexicalUnit.open_parenthesis
    c = LexicalUnit.numeric('40')
    d = LexicalUnit.operator('+')
    e = LexicalUnit.numeric('9')
    f = LexicalUnit.closed_parenthesis
    sya = Sya.new([a, b, c, d, e, f])

    # sqrt + 40 9
    expect(sya.run).to eq [a, d, c, e]
  end

end
