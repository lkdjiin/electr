module Electr

  # Prints the computation.
  class Printer

    def run(result)
      if result == result.truncate
        puts result.truncate
      else
        puts result.round(10)
      end
    end

    def run_ast(ast)
      ast.display
    end

  end
end
