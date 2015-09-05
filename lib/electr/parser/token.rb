module Electr::Token

  refine String do

    def numeric?
      self =~ /[0-9.]\Z/
    end

    def operator?
      %w( + - / ).include?(self)
    end

    def constant?
      %w( pi ).include?(self)
    end

    def value?
      # The unit part is redondant with Tokenizer.
      self =~ /[0-9.][kKRuFpΩμAmWV]{1,}\Z/
    end

  end

end
