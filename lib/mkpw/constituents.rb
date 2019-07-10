module Mkpw
  class Constituents
    extend Forwardable
    include Comparable
    include Enumerable

    def_delegators(
      :@items,
      :<=>,
      :each,
      :length
    )

    attr_reader :items

    def initialize(items)
      validate!(items)
      @items = items.freeze
    end

    ##
    # Alphas#select_random returns one or more alpha characters
    #
    # @param quantity *optional* Number of characters to return; defaults to 1
    #
    # @return [Array] of selected characters
    #
    def select_random(quantity: 1)
      [].tap { |selection| quantity.times { selection << items.sample } }
    end

    private

    def validate!(constituent_set)
      constituent_set.each do |item|
        raise Mkpw::NotAString, item unless item.is_a?(String)
      end
    end
  end
end