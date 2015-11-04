module Electr

  # Prints the computation.
  class Printer

    # result - Anything that respond to `truncate` and `round`.
    #
    # One can certainly benifit from a new type, say ElectrValue, as the
    # type of `result`.
    def self.run(result)
      truncated = result.truncate
      puts result == truncated ? truncated : result.round(10)
    end

  end
end
