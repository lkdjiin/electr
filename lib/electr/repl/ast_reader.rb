module Electr

  # Special reader for a REPL that display an AST instead of the
  # computation.
  class ASTReader < BaseReader

    def initialize
      super("E--ast> ")
    end

    def run
      prompt
      Compiler.compile_to_ast(STDIN.gets.chomp)
    end

  end
end
