module Electr

  class Repl

    BANNER = "\nElectr version #{Electr::VERSION}\n" +
             "A tiny language for electronic formulas\n\n" +
             "Hit Ctrl+C to quit Electr\n\n"

    def run
      puts BANNER
      _print(_eval(_read)) while true
    end

    private

    def _read
      print("E> ")
      line = STDIN.gets.chomp
      compiler = Compiler.new
      compiler.compile_to_pn(line)
    end

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

  end
end
