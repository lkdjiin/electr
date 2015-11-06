module Electr

  # Normal reader for the REPL.
  class Reader < BaseReader

    def initialize(readline_lib = Readline)
      super("E> ", readline_lib)
    end

    def run
      line = @readline.readline(@prompt, true)
      return if line.nil?
      Compiler.compile_to_pn(line)
    end

  end
end
