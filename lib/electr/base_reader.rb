module Electr

  # Responsible of the terminal interface, that is printing the prompt
  # and reading a line of code (I know, I know, there is an «and» in the
  # description…).
  class BaseReader

    def initialize(prompt = "No prompt defined> ")
      @prompt = prompt
    end

    def run
      raise(NotImplementedError)
    end

    private

    def prompt
      print(@prompt)
    end

  end
end
