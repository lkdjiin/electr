module Electr

  class Repl

    BANNER = "\nElectr version #{Electr::VERSION}\n" +
             "A tiny language for electronic formulas\n\n" +
             "Hit Ctrl+C to quit Electr\n\n"

    def initialize(options)
      @options = options
      puts BANNER
    end

    def run
      if @options[:ast]
        print_ast(read_ast) while true
      else
        _print(_eval(_read)) while true
      end
    end

    private

    def _read
      print("E> ")
      line = STDIN.gets.chomp
      compiler = Compiler.new
      compiler.compile_to_pn(line)
    end

    def read_ast
      print("E--ast> ")
      line = STDIN.gets.chomp
      compiler = Compiler.new
      compiler.compile_to_ast(line)
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

    def print_ast(ast)
      ast.display
    end

  end
end
