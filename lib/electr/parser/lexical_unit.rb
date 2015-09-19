module Electr

  # Holds some data about a lexica unit (lexeme) of the language.
  class LexicalUnit

    private_class_method :new

    attr_reader :type, :value

    # Create a new LexicalUnit.
    #
    # type  - Symbol
    # value - String
    def initialize(type, value)
      @type = type
      @value = value
    end

    def self.numeric(value)     ; new(:numeric, value)          ; end
    def self.operator(value)    ; new(:operator, value)         ; end
    def self.constant(value)    ; new(:constant, value)         ; end
    def self.value(value)       ; new(:value, Value.assert(value)) ; end
    def self.name(value)        ; new(:name, value)             ; end
    def self.fname(value)       ; new(:fname, value)            ; end
    def self.fcall(value)       ; new(:fcall, value)            ; end
    def self.open_parenthesis   ; new(:open_parenthesis, "(")   ; end
    def self.closed_parenthesis ; new(:closed_parenthesis, ")") ; end

    def ==(other)
      @type == other.type && @value == other.value
    end

    def numeric?
      @type == :numeric
    end

    def operator?
      @type == :operator
    end

    def unary_minus?
      operator? && @value == UNARY_MINUS_INTERNAL_SYMBOL
    end

    def constant?
      @type == :constant
    end

    def value?
      @type == :value
    end

    def fname?
      @type == :fname
    end

    def number?
      numeric? || constant? || value?
    end

    def closed_parenthesis?
      @type == :closed_parenthesis
    end

    def open_parenthesis?
      @type == :open_parenthesis
    end

  end
end
