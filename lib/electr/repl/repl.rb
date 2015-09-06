module Electr

  # The Read Eval Print Loop starting point.
  class Repl

    BANNER = "\nElectr version #{Electr::VERSION}\n" +
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
      run_once while true
    end

    def run_once
      @printer.run(@eval.evaluate_pn(@reader.run))
    end

  end
end
