module Electr

  # Prints the computation.
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
      else
        print_error
      end
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
