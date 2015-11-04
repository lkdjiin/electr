require 'spec_helper'

include Electr

describe ElectrValue do

  it "holds a number" do
    result = ElectrValue.new(10)
    expect(result.number).to eq 10
  end

  it "has type number" do
    result = ElectrValue.new(10)
    expect(result.type).to eq :number
  end

  it "knows it is a number" do
    result = ElectrValue.new(10)
    expect(result.number?).to eq true
    expect(result.error?).to eq false
  end

  it "holds an error message" do
    result = ElectrValue.error("message")
    expect(result.error).to eq "message"
  end

  it "has type error" do
    result = ElectrValue.error("message")
    expect(result.type).to eq :error
  end

  it "knows it is a error" do
    result = ElectrValue.error("message")
    expect(result.error?).to eq true
    expect(result.number?).to eq false
  end

  describe "==" do
    it "is equal when all same members" do
      a = ElectrValue.new(10, :number, "foo")
      b = ElectrValue.new(10, :number, "foo")
      expect(a.object_id).not_to eq b.object_id
      expect(a).to eq b
    end

    it "isn't equal when different types" do
      a = ElectrValue.new(10, :number, "foo")
      b = ElectrValue.new(10, :error, "foo")
      expect(a).not_to eq b
    end

    it "isn't equal when different classes" do
      a = ElectrValue.new(10, :number, "foo")
      b = 10
      expect(a).not_to eq b
    end

  end

end
