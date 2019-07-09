module Mkpw
  DEFAULT_ALPHAS = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

  class Alphas
    attr_reader :alphas
    def initialize(add_chars: nil, only_chars: nil)
      @alphas = if !only_chars.nil?
        only_chars
      elsif !add_chars.nil?
        DEFAULT_ALPHAS + add_chars
      else
        DEFAULT_ALPHAS
      end.freeze
    end

    ##
    # Alphas#select returns one or more alpha characters
    #
    # @param quantity *optional* Number of characters to return; defaults to 1
    #
    # @return [Array] of selected characters
    #
    def select(quantity: 1)
      [].tap { |selection| quantity.times { selection << alphas.sample } }
    end
  end
end