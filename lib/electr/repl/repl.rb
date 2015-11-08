module Electr

  # The Read Eval Print Loop starting point.
  class Repl

    BANNER = "\nElectr version #{VERSION} (codename «#{CODENAME}»)\n" +
             "A tiny language for electronic formulas\n\n" +
             "Hit Ctrl+C to quit Electr\n\n"

    def initialize(reader = Reader.new,
                   evaluator = Evaluator.new,
                   printer = Printer)
      @reader = reader
      @eval = evaluator
      @printer = printer
    end

    def run
      puts BANNER
      loop do
        got_input = run_once
        break unless got_input
      end
    end

    def run_once
      input = @reader.run
      return false if input.nil?
      @printer.run(@eval.evaluate_pn(input)) || true
    end

  end
end
