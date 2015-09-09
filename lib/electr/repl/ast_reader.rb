module Electr

  # Special reader for a REPL that display an AST instead of the
  # computation.
  class ASTReader < BaseReader

    def initialize(readline_lib = Readline)
      super("E--ast> ", readline_lib)
    end

    def run
      line = @readline.readline(@prompt, true)
      Compiler.compile_to_ast(line)
    end

  end
end
