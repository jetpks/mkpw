#!/usr/bin/env ruby

class Mkpw
  attr_reader :words, :nums, :alphas, :symbols, :components
  def initialize(alphas: nil, nums: nil, symbols: nil, words: nil)
    @words = (words || File.readlines('/usr/share/dict/words')).freeze
    @nums = (nums || (0..9).to_a).freeze
    @alphas = (alphas || ('a'..'z').to_a + ('A'..'Z').to_a).freeze
    @symbols = (symbols || ',./<>?;:-=_+&*%^#$!@~|'.chars).freeze
    @components = { alphas: @alphas, nums: @nums, words: @words, symbols: @symbols }.freeze
  end

  def generate_word_pass(word_qty: 2)
    {seperator: compose.join, words: words.sample(word_qty).map(&:chomp)}
  end

  def compose(width: 2, weights: {nums: 0.5, symbols: 0.5})
    total = 0
    weights.map {|set,weight| total += weight}
    weights.map {|set,weight| components[set.to_sym].sample((weight / total) * width)}.shuffle
  end
end
