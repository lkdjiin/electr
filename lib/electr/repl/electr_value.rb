module Electr

  # ElectrValue is the container of an evaluation's result.
  #
  # The result of the evaluation step can be of three types:
  #
  # - number
  # - error
  # - hidden
  #
  # The type number is the most common one. It's, you know, just a number.
  # It's the result of the evaluation of `2k 3`, which is the number 6000.
  # An ElectrValue of type number is meant to be printed on the screen.
  #
  # If an evaluation raised an error, it produced an ElectrValue of type
  # error. This ElectrValue holds the error message.
  #
  # The type hidden is just a special case of a number. It is produced as
  # the result of the evaluation of an assignment. That is, `R1 = 100`
  # produces an ElectrValue of type hidden. It holds the number 100 but is
  # not likely to be printed on the screen, thus the type hidden.
  #
  # Creating a new ElectrValue is done using class constructors:
  #
  #   ElectrValue.number(100.0)
  #   ElectrValue.hidden(200.0)
  #   ElectrValue.error("Bad syntax error!")
  #
  # The class has dedicated method to check the various types:
  #
  #   val = ElectrValue.number(100.0)
  #   val.number? #=> true
  #   val.hidden? #=> false
  #   val.error?  #=> false
  class ElectrValue

    def self.number(number)
      new(number)
    end

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
    private_class_method :new

    attr_reader :number, :type, :error

    def number?
      @type == :number
    end

    def error?
      @type == :error
    end

    def hidden?
      @type == :hidden
    end

    # Say it's equal only if all three fields are equals. This is enough
    # for now and there is no needs to check equality type by type.
    def ==(other)
      return false unless other.is_a?(ElectrValue)
      @number == other.number && @type == other.type && @error = other.error
    end

  end
end
