module Electr

  class LexicalUnit::Value

    def self.assert(value)
      new(value).assert
    end

    def initialize(value)
      @value = value
      @unit = nil
      @prefix = nil
      @abbreviation = false
      find_unit_attributes
    end

    def assert
      if good_unit?
        @value
      else
        raise(SyntaxError, "Unknow unit: #@unit in #@value")
      end
    end

    private

    def find_unit_attributes
      find_unit
      maybe_split_unit
    end

    def find_unit
      index = 0
      index += 1 while @value[index] =~ /[\d._, -]/
      @unit = @value[index..-1]
    end

    def maybe_split_unit
      if abbreviation?
        @abbreviation = true
      elsif prefix?
        fill_prefix_and_unit
      end
    end

    def abbreviation?
      @unit.size == 1 && ABBREVIATIONS.include?(@unit)
    end

    def prefix?
      PREFIXES.include?(@unit[0])
    end

    def fill_prefix_and_unit
      @prefix = @unit[0]
      @unit = @unit[1..-1]
    end

    def good_unit?
      @abbreviation || UNITS.include?(@unit)
    end

  end
end
