module Electr

  # First step of the parser. Explode a code in its constituant, ie
  # `sqrt(3+2)` becomes the list `sqrt`, `(`, `3`, `+`, `2`, `)`.
  class Tokenizer

    ONE_CHAR_SYMBOLS = %w( + - / )

    def initialize(string)
      @index = 0
      @token = ''
      @look_ahead = ''
      @codeline = string
      forward_look_ahead
    end

    def has_more_token?
      @index <= @codeline.size
    end

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

    def produce_next_token
      if @look_ahead =~ /[0-9]/
        get_number
      elsif ONE_CHAR_SYMBOLS.include?(@look_ahead)
        add_this_char
      elsif @look_ahead == '('
        add_this_char
      elsif @look_ahead == ')'
        add_this_char
      else
        get_word
      end
    end

    def skip_white
      forward_look_ahead while @look_ahead == ' '
    end

    def get_number
      add_look_ahead while @look_ahead =~ /[0-9.]/
      if @token[-1] != '.'
        add_look_ahead while @look_ahead =~ /[kKRuFpΩμAmWV]/
      end
      @token
    end

    def add_look_ahead
      @token << @look_ahead
      forward_look_ahead
    end

    def get_word
      add_look_ahead while @look_ahead =~ /\w/
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
