module Electr
  module Token

    refine String do

      def numeric?
        # I know it isn't the best regexp I can do…
        self =~ /\A-?[\d\.,_]+\z/
      end

      def operator?
        [*ONE_CHAR_OPERATORS, UNARY_MINUS_INTERNAL_SYMBOL].include?(self)
      end

      def constant?
        %w( pi ).include?(self)
      end

      def value?
        # The unit part is redondant with Tokenizer.
        self =~ /[\d.] ?[A-Za-zΩ℧μ]{1,}\z/
      end

      def variable?
        self =~ /\A[A-Z]\d+\z/
      end

    end

  end
end
