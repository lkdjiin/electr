module Electr

  # The Read Eval Print Loop starting point.
  class Repl

    BANNER = "\nElectr version #{Electr::VERSION}\n" +
             "A tiny language for electronic formulas\n\n" +
             "Hit Ctrl+C to quit Electr\n\n"

    def initialize(reader = Reader.new, printer = printer.new)
      puts BANNER
      @reader = reader
      @printer = printer
    end

    def run
      run_once while true
    end

    def run_once
      @printer.run(_eval(@reader.run))
    end

    def run_ast
      run_ast_once while true
    end

    def run_ast_once
      @printer.run_ast(@reader.run_ast)
    end

    private

    def _eval(pns)
      evaluator = Evaluator.new
      evaluator.evaluate_pn(pns)
    end

  end
end
