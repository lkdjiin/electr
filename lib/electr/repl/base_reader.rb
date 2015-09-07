module Electr

  # Responsible of the terminal interface, that is printing the prompt
  # and reading a line of code (I know, I know, there is an «and» in the
  # description…). This is a base class intended for inheritance.
  class BaseReader

    # Creates a new BaseReader.
    #
    # prompt       - String prompt to be displayed to the user.
    # readline_lib - The app should always use Readline, but injected
    #                the Module here could ease the tests…
    def initialize(prompt = "No prompt defined> ",
                   readline_lib = Readline)
      @prompt = prompt
      @readline = readline_lib
    end

    def run
      raise(NotImplementedError)
    end

  end
end
