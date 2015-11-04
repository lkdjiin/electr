module Electr

  # ElectrValue is the holder of an evaluation's result.
  class ElectrValue

    def self.error(message)
      new(0, :error, message)
    end

    def self.hidden(number)
      new(number, :hidden)
    end

    def initialize(number, type = :number, message = "")
      @number = number
      @type = type
      @error = message
    end

    attr_reader :number, :type, :error, :hidden

    def number?
      @type == :number
    end

    def error?
      @type == :error
    end

    def hidden?
      @type == :hidden
    end

    def ==(other)
      return false unless other.is_a?(ElectrValue)
      @number == other.number && @type == other.type && @error = other.error
    end

  end
end
