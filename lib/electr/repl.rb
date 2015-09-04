module Electr

  class Repl

    BANNER = "\nElectr version #{Electr::VERSION}\n" +
             "A tiny language for electronic formulas\n\n" +
             "Hit Ctrl+C to quit Electr\n\n"

    def initialize
      puts BANNER
      @reader = Reader.new
      @printer = Printer.new
    end

    def run
      @printer.run(_eval(@reader.run)) while true
    end

    def run_ast
      @printer.run_ast(@reader.run_ast) while true
    end

    private

    def _eval(pns)
      evaluator = Evaluator.new
      evaluator.evaluate_pn(pns)
    end

  end
end
