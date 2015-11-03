module Electr
  module Token

    refine String do

      def numeric?
        self =~ /\A-?[0-9\.,_]+\z/
      end

      def operator?
        [*ONE_CHAR_OPERATORS, UNARY_MINUS_INTERNAL_SYMBOL].include?(self)
      end

      def constant?
        %w( pi ).include?(self)
      end

      def value?
        # The unit part is redondant with Tokenizer.
        self =~ /[0-9.][A-Za-zΩ℧μ]{1,}\z/
      end

      def variable?
        self =~ /\A[A-Z][0-9]+\z/
      end

    end

  end
end
