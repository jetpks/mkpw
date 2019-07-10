module Mkpw
  DEFAULT_SYMBOLS = %w{ , . / < > ? ; : - = _ + & * % ^ # $ ! @ ~ | }

  class Symbols < Constituents
    def initialize(add: nil, only: nil)
      super(DEFAULT_SYMBOLS, add: add, only: only)
    end
  end
end
