module Electr

  class Repl

    BANNER = "\nElectr version #{Electr::VERSION}\n" +
             "A tiny language for electronic formulas\n\n" +
             "Hit Ctrl+C to quit Electr\n\n"

    def initialize
      puts BANNER
      @reader = Reader.new
    end

    def run
      _print(_eval(@reader.run)) while true
    end

    def run_ast
      print_ast(@reader.run_ast) while true
    end

    private

    def _eval(pns)
      evaluator = Evaluator.new
      evaluator.evaluate_pn(pns)
    end

    def _print(result)
      if result == result.truncate
        puts result.truncate
      else
        puts result.round(10)
      end
    end

    def print_ast(ast)
      ast.display
    end

  end
end
