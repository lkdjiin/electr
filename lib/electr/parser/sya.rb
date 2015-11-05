module Electr

  # Shunting Yard Algorithm.
  #
  # It produces prefix notation instead of the most common reverse
  # polish notation to ease producing the AST.
  #
  # For a starter, see https://en.wikipedia.org/wiki/Shunting-yard_algorithm
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
    # Returns Array of LexicalUnit ordered in prefix notation.
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
          @operator.pop # Pop the right parenthesis.
          if @operator.last && @operator.last.type == :fname
            @output.push(@operator.pop)
          end
          # If the stack runs out without finding a right parenthesis,
          # then there are mismatched parentheses.
        elsif unit.operator? || unit.assign?

          @output.push(@operator.pop) while rules_for_operator_are_met(unit)
          @operator.push(unit)

        end
      end

      @output.push(@operator.pop) while @operator.size > 0

      @output.reverse
    end

    private

    def rules_for_operator_are_met(unit)
      size_rule && (operator_rule && associative_rule(unit))
    end

    def size_rule
      @operator.size > 0
    end

    def operator_rule
      test = @operator.last
      test.operator? || test.fname? || test.assign?
    end

    def associative_rule(test)
      left_associative_rule(test) || right_associative_rule(test)
    end

    def left_associative_rule(test)
      left_associative(test) && left_assoc_precedence_rule(test)
    end

    def left_assoc_precedence_rule(test)
      precedence(test) < precedence(@operator.last)
    end

    def right_associative_rule(test)
      right_associative(test) && right_assoc_precedence_rule(test)
    end

    def right_assoc_precedence_rule(test)
      precedence(test) <= precedence(@operator.last)
    end

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

    # Check the left associativity of an operator.
    #
    # operator - LexicalUnit operator.
    #
    # Returns true if the operator is left associative, false otherwise.
    def left_associative(operator)
      if operator.fname?
        PRECEDENCE['()'][:assoc] == 'L'
      else
        PRECEDENCE[operator.value][:assoc] == 'L'
      end
    end

    # Check the right associativity of an operator.
    #
    # operator - LexicalUnit operator.
    #
    # Returns true if the operator is right associative, false otherwise.
    def right_associative(operator)
      if operator.fname?
        PRECEDENCE['()'][:assoc] == 'R'
      else
        PRECEDENCE[operator.value][:assoc] == 'R'
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
