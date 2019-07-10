# frozen_string_literal: true

module Mkpw
  DEFAULT_ALPHAS = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

  class Alphas < Constituents
    def initialize(add: nil, only: nil)
      super(DEFAULT_ALPHAS, add: add, only: only)
    end
  end
end
