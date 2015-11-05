module Electr

  # It knows how to print the result of an evaluation.
  class Printer

    # result - The ElectrValue result of an evaluation.
    def self.run(result)
      new(result).print
    end

    def initialize(result)
      @result = result
    end

    def print
      if @result.number?
        print_number
      elsif @result.error?
        print_error
      end
      # If hidden, print nothing.
    end

    def print_number
      number = @result.number
      truncated = number.truncate
      puts number == truncated ? truncated : number.round(10)
    end

    def print_error
      puts @result.error
    end

  end
end
