module Electr

  # Shunting Yard Algorithm.
  #
  # It produces prefix notation instead of the most common reverse
  # polish notation to ease producing the AST.
  class Sya

    # Creates a new Sya.
    #
    # lexical_units - Array of LexicalUnit in the order they have been
    #                 parsed (natural/infix ordering).
    def initialize(lexical_units)
      @units = lexical_units
      insert_multiplication
      @output = []
      @operator = []
    end

    # Public: Run the Shunting Yard Algorithm.
    #
    # Returns Array of LexicalUnit ordered with prefix notation.
    def run
      while unit = @units.pop
        if unit.number? || unit.variable?
          @output.push(unit)
        elsif unit.fname?
          @operator.push(unit)
        elsif unit.type == :closed_parenthesis
          @operator.push(unit)
        elsif unit.type == :open_parenthesis
          while @operator.last &&
                @operator.last.type != :closed_parenthesis
            @output.push(@operator.pop)
          end
          rparen = @operator.pop
          if @operator.last && @operator.last.type == :fname
            @output.push(@operator.pop)
          end
          # If the stack runs out without finding a right parenthesis,
          # then there are mismatched parentheses.
        elsif unit.operator? || unit.assign?
          while @operator.size > 0 &&
                (@operator.last.operator? || @operator.last.fname?) &&
                (precedence(unit) < precedence(@operator.last))
            @output.push(@operator.pop)
          end
          @operator.push(unit)
        end
      end

      @output.push(@operator.pop) while @operator.size > 0

      @output.reverse
    end

    private

    # Look up the precedence of an operator.
    #
    # operator - LexicalUnit operator.
    #
    # Returns the Fixnum precedence of `operator`.
    def precedence(operator)
      if operator.fname?
        PRECEDENCE['()'][:val]
      else
        PRECEDENCE[operator.value][:val]
      end
    end

    # Insert the multiplication operator (`*`) where it is needed inside
    # the @units member. This is because in Electr the `*` is implicit.
    #
    # Examples
    #
    #   # @units before: 2 3
    #   # @units after:  2 * 3
    #
    # Returns nothing.
    def insert_multiplication
      new_units = []
      while unit = @units.shift
        new_units << unit
        if maybe_insertion_needed?(unit)
          new_units << LexicalUnit.operator('*') if insertion_needed?
        end
      end
      @units = new_units
    end

    def maybe_insertion_needed?(unit)
      unit_ahead && (unit.number? || unit.variable?)
    end

    def insertion_needed?
      unit_ahead.number? || unit_ahead.open_parenthesis? ||
      unit_ahead.fname? || unit_ahead.unary_minus? || unit_ahead.variable?
    end

    def unit_ahead
      @units.first
    end

  end
end
