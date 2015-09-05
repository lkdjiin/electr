module Electr

  # Prints the computation.
  class Printer

    def self.run(result)
      truncated = result.truncate
      puts result == truncated ? truncated : result.round(10)
    end

  end
end
