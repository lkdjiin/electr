module Electr

  # Starting point for the rules.
  #
  # TODO Is this really needed?
  class RootRule < BaseRule

    def apply!
      root_node = RootAST.new
      while more_units?
        ExpressionRule.new(@units, root_node).apply!
      end
      @ast_node.add_child(root_node)
    end

    private

    def more_units?
      @units.size > 0
    end

  end
end

