module Electr

  # ElectrValue is the holder of an evaluation's result.
  class ElectrValue

    def self.error(message)
      new(0, :error, message)
    end

    def initialize(number, type = :number, message = "")
      @number = number
      @type = type
      @error = message
    end

    attr_reader :number, :type, :error

    def number?
      @type == :number
    end

    def error?
      @type == :error
    end

    def ==(other)
      return false unless other.is_a?(ElectrValue)
      @number == other.number && @type == other.type && @error = other.error
    end

  end
end
