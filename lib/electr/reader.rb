module Electr

  # Normal reader for the REPL.
  class Reader < BaseReader

    def initialize
      super("E> ")
    end

    def run
      prompt
      Compiler.new.compile_to_pn(STDIN.gets.chomp)
    end

  end
end
