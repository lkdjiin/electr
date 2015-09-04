module Electr

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
      print " " * indent + @name
      if leaf?
        print " ::= #@value"
      else
        print " (#@value)" if @value
      end
      puts
      @children.each {|child| child.display(indent + 2) }
    end

    def to_pn
      [* Pn.new(@value, @name)] + @children.map {|child| child.to_pn }.flatten
    end

  end

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
