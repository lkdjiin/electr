require 'spec_helper'

include Electr

describe ElectrValue do

  describe "number" do

    it "holds a number" do
      result = ElectrValue.number(10)
      expect(result.number).to eq 10
    end

    it "has type number" do
      result = ElectrValue.number(10)
      expect(result.type).to eq :number
    end

    it "knows it is a number" do
      result = ElectrValue.number(10)
      expect(result.number?).to eq true
      expect(result.error?).to eq false
    end
  end

  describe "error" do

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
  end

  describe "hidden" do

    it "holds a hidden number" do
      result = ElectrValue.hidden(10)
      expect(result.number).to eq 10
    end

    it "has type hidden" do
      result = ElectrValue.hidden(10)
      expect(result.type).to eq :hidden
    end

    it "knows it is a hidden number" do
      result = ElectrValue.hidden(10)
      expect(result.number?).to eq false
      expect(result.hidden?).to eq true
    end
  end

  describe "==" do
    it "is equal when all same members" do
      a = ElectrValue.number(10)
      b = ElectrValue.number(10)
      expect(a.object_id).not_to eq b.object_id
      expect(a).to eq b
    end

    it "isn't equal when different types" do
      a = ElectrValue.number(10)
      b = ElectrValue.error("foo")
      expect(a).not_to eq b
    end

    it "isn't equal when different classes" do
      a = ElectrValue.number(10)
      b = 10
      expect(a).not_to eq b
    end

  end

end
