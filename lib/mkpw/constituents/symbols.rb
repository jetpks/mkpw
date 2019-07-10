# frozen_string_literal: true

module Mkpw
  DEFAULT_SYMBOLS = %w[, . / < > ? ; : - = _ + & * % ^ # $ ! @ ~ |].freeze

  class Symbols < Constituents
    def initialize(add: nil, only: nil)
      super(DEFAULT_SYMBOLS, add: add, only: only)
    end
  end
end
