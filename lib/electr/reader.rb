module Electr

  # Responsible of the terminal interface, that is printing the prompt
  # and reading a line of code (I know, I know, there is an «and» in the
  # description…).
  class Reader

    def run
      prompt("E> ")
      compiler = Compiler.new
      compiler.compile_to_pn(get_line)
    end

    def run_ast
      prompt("E--ast> ")
      compiler = Compiler.new
      compiler.compile_to_ast(get_line)
    end

    private

    def prompt(str)
      print(str)
    end

    def get_line
      STDIN.gets.chomp
    end

  end
end
