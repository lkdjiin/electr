module Electr

  class BaseRule

    # Initialize a new rule. The units and ast_node objects
    # given in arguments will be modified by #apply!.
    #
    # units    - Array of LexicalUnits.
    # ast_node - An AST object, for adding children, etc.
    def initialize(units, ast_node)
      @units = units
      @ast_node = ast_node
      @series = []
    end

    # Public: Apply the rule to the list of lexical units, creating
    # and/or modifying the ast node. #apply! modify the units and
    # ast_node objects given to #initialize.
    def apply!
      raise NotImplementedError
    end

    private

    # Accepts the next lexical unit, given type match the unit type.
    # If value is given, it has to match the unit value.
    #
    # type  - Expected Symbol type of the next unit.
    # value - Expected String value of the next unit. Default is the
    #         empty string, meaning the value doesn't matter.
    #
    # Returns nothing.
    # Raises SyntaxError if type or value doesn't match.
    def accept(type, value = '')
      unit = @units.slice!(0)
      @series << unit
      unless unit.type == type
        raise(SyntaxError, "Expected type : #{type}\n" +
                           "Expected value: #{value}\n" +
                           "Got type      : #{unit.type}\n" +
                           "Got value     : #{unit.value}")
      end
      if value != ''
        raise SyntaxError unless unit.value == value
      end
    end

    # A shortcut method to #accept. Usefull when we have several calls
    # to #accept. Calls #accept for each of the symbol in args.
    #
    # args - A series of Symbol.
    #
    # Returns nothing.
    def accept_all(*args)
      args.each {|arg| accept(arg) }
    end

  end
end

