module Mkpw
  DEFAULT_ALPHAS = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

  class Alphas < Constituents
    def initialize(add: nil, only: nil)
      alphas_set = if !only.nil?
        only
      elsif !add.nil?
        DEFAULT_ALPHAS + add
      else
        DEFAULT_ALPHAS
      end

      super(alphas_set)
    end
  end
end