# frozen_string_literal: true

module Mkpw
  DEFAULT_NUMBERS = (0..9).map(&:to_s).freeze

  class Numbers < Constituents
    def initialize(add: nil, only: nil)
      super(DEFAULT_NUMBERS, add: add, only: only)
    end
  end
end
