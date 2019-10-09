# frozen_string_literal: true

module Mkpw
  ##
  # Mkpw::UglyPass's main usecase is to provide "seperating" strings for
  # Mkpw::WordyPass. WordyPass use separating strings to meet the number &
  # symbol password requirements that old systems use. In other words, being
  # well formed is our top priority.
  #
  # Let's define well formed to have mean the following:
  #
  # 1. Requested length will always be matched exactly. Having `length: 2`
  #    UglyPass will *always* result in a `#length == 2` result. _Even when more
  #    than two Constituent classes have non-zero weights_.
  #
  # 2. All constituent classes with non-zero weights are accounted for in the
  # resulting password, space permitting.
  #
  #   If we have a `length: 2` and `weights: { numbers: 0.5, symbols: 0.5 }`, you
  #   can count on the resulting UglyPass to have exactly one number, and exactly
  #   one symbol _always_.
  #
  #   If we have a `length: 2` and `weights: { numbers: 0.5, symbols: 0.5,
  #   alphas: 0.5 }`, the resulting UglyPass only contain two of the weight
  #   categories. There's not enough room to put in all three. The two "winning"
  #   character sets are those with the highest weights, or if equivalent
  #   weights, chosen at random.
  #
  #   For example:
  #
  #   input: `length: 2, weights: { alphas: 2, symbols: 2, numbers: 1 }`
  #   output: `[ :alpha, :symbol ]` # _never_ a :number, because of the weights
  #
  #   input: `length: 3, weights: { alphas: 2, symbols: 2, numbers: 1 }`
  #   output: `[ :alpha, :symbol, :number ]` # _always_ this ratio; random
  #   placement
  #
  #   input: `length: 2, weights: { alphas: 1, symbols: 1, numbers: 1 }`
  #   output: One of the following ratios but with a random order:
  #     * `[ :alpha, :symbol ]` OR
  #     * `[ :symbol, :number ]` OR
  #     * `[ :alpha, :number ]`
  #

  class UglyPass
    attr_accessor :length, :weights
    attr_reader :weights

    def initialize(length: 2, weights: { numbers: 0.5, symbols: 0.5 })
      @length = length
      @weights = weights.freeze
    end

    def weights=(new_weights)
      reset!
      @weights = new_weights.freeze
    end

    def generate
      scaffold
        .map { |component, quantity| Mkpw::COMPONENTS[component].select_random(quantity: quantity) }
        .flatten
        .shuffle
        .join
    end

    private

    def components
      Mkpw::COMPONENTS
    end

    def proportions
      @proportions ||= {}.tap do |p|
        total = weights.values.reduce(:+).to_f

        weights.each do |set, weight|
          ratio = weight / total
          p[set] = ratio if ratio > 0
        end
      end
    end

    def reset!
      @proportions = nil
      @scaffold = nil
    end

    def scaffold
      optimal = proportions.transform_values { |v| (v * length) }
      rle = optimal.transform_values(&:ceil)

      until rle.values.reduce(&:+) == length
        candidates = rle.filter { |_, v| v > 1 }

        # edge case: all 1s; this means length < scaffold.size
        if candidates.empty?
          rle.delete(rle.keys.sample)
          next
        end

        highest_variance = candidates
                           .map { |k, v| { k => v - optimal[k] } }
                           .max { |a, b| a.values.first <=> b.values.first }
                           .keys
                           .first

        rle[highest_variance] = rle[highest_variance] - 1
      end

      rle
    end
  end
end
