module Electr

  # Shunting Yard Algorithm.
  #
  # It produces prefix notation instead of the most common reverse
  # polish notation to ease producing the AST.
  class Sya

    PRECEDENCE = {
      '()' => {assoc: 'L', val: 99},
      ')'  => {assoc: 'L', val: 99},
      '('  => {assoc: 'L', val: 99},
      '*'  => {assoc: 'L', val: 10},
      '/'  => {assoc: 'L', val: 10},
      '-'  => {assoc: 'L', val:  1},
      '+'  => {assoc: 'L', val:  1},
    }

    # lexical_units - Array of LexicalUnit in the order they have been
    #                 parsed (natural ordering).
    def initialize(lexical_units)
      @units = lexical_units
      insert_multiplication
      @output = []
      @operator = []
    end

    # Run the Shunting Yard Algorithm.
    #
    # Returns Array of LexicalUnit ordered with prefix notation.
    def run
      while unit = @units.pop
        if unit.number?
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
        elsif unit.operator?
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
      temp = []
      while unit = @units.shift
        temp << unit
        if @units.first
          if (@units.first.number? && unit.number?) ||
             (@units.first.open_parenthesis? && unit.number?) ||
             (@units.first.fname? && unit.number?)
            temp << LexicalUnit.operator('*')
          end
        end
      end
      @units = temp
    end

  end
end
