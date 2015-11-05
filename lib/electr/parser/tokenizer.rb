module Electr

  # The tokenizer is the first step of the parser. It explodes a code in
  # its constituants (token), ie # `sqrt(3+2)` becomes the following
  # list of tokens:
  #
  # - `sqrt`
  # - `(`
  # - `3`
  # - `+`
  # - `2`
  # - `)`
  class Tokenizer

    # Create a new Tokenizer for a specific code.
    #
    # string - The String code to tokenize.
    def initialize(string)
      @index = 0
      @token = ''
      @look_ahead = ''
      @codeline = string
      forward_look_ahead
    end

    # Public: Check if the tokenizer is able to give another token.
    #
    # Returns Boolean true if there is another waiting token.
    def has_more_token?
      @index <= @codeline.size
    end

    # Public: Get the next token.
    #
    # Returns a String token.
    def next_token
      ret = produce_next_token
      skip_white
      @token = ''
      ret
    end

    private

    def forward_look_ahead
      @look_ahead = @codeline[@index, 1]
      @index += 1
    end

    def add_look_ahead
      @token << @look_ahead
      forward_look_ahead
    end

    def produce_next_token

      if begin_like_number?
        get_number

      elsif unary_minus?
        get_unary_minus

      elsif ONE_CHAR_OPERATORS.include?(@look_ahead)
        add_this_char

      elsif %w( \( \) = ).include?(@look_ahead)
        add_this_char

      elsif variable?
        get_variable

      else
        get_word
      end
    end

    def skip_white
      forward_look_ahead while @look_ahead == ' '
    end

    def begin_like_number?
      @look_ahead =~ /[0-9.]/ ||
      (@look_ahead == '-' && @codeline[@index] =~ /[0-9.]/)
    end

    def unary_minus?
      # We are able to recognize the unary minus operator only when it
      # is followed by a name (constant or function) or an open
      # parenthesis.
      @look_ahead == '-' && @codeline[@index] =~ /[a-z\(]/
    end

    def variable?
      @look_ahead =~ /[A-Z]/ && @codeline[@index] =~ /[0-9]/
    end

    def get_unary_minus
      @look_ahead = UNARY_MINUS_INTERNAL_SYMBOL
      add_look_ahead
      @token
    end

    def get_number
      add_look_ahead if @look_ahead == '-'
      add_look_ahead while @look_ahead =~ /[0-9._,]/
      if @token[-1] != '.'
        add_look_ahead while @look_ahead =~ /[A-Za-zΩ℧μ]/
      end
      @token
    end

    def get_variable
      add_look_ahead
      add_look_ahead while @look_ahead =~ /[0-9]/
      @token
    end

    def get_word
      add_look_ahead while @look_ahead =~ /[\w√]/
      # At this point, an empty token means that we have reached an
      # illegal word.
      raise(SyntaxError, @codeline) if @token.empty?
      @token
    end

    # Add current character to the current token and return it.
    # Usefull shorthand for single character's tokens.
    #
    # Returns the String current token.
    def add_this_char
      add_look_ahead
      @token
    end

  end
end
