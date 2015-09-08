module Electr

  # Base class for the abstract syntax tree.
  class AST

    def initialize(name)
      if name
        @name = name
      else
        @name = self.class.name.split('::').last
      end
      @children = []
      @value = nil
    end

    attr_reader :value, :name, :children

    # Public: Add a child node to the end of the children's list.
    #
    # child - An AST node to add to the list of children.
    #
    # Returns self.
    def add_child child
      @children << child
      self
    end

    # Public: Returns True if this node is a leaf.
    def leaf?
      @children.empty?
    end

    def size
      @children.size
    end

    def display(indent = 0)
      print name_for_display(indent)
      print value_for_display
      puts
      @children.each {|child| child.display(indent + 2) }
    end

    def to_pn
      [* Pn.new(@value, @name)] + @children.map {|child| child.to_pn }.flatten
    end

    private

    def name_for_display(indent)
      " " * indent + @name
    end

    def value_for_display
      if leaf?
        " ::= #@value"
      else
        " (#@value)" if @value
      end
    end

  end

  # Element of a prefix notation.
  # TODO Pn is not a good name!
  class Pn

    def initialize(value, name)
      @value = value
      @name = name
    end

    attr_reader :value, :name

    def to_f
      value.tr(',', '_').to_f
    end
  end

end
