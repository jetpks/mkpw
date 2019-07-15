# frozen_string_literal: true

require 'colorize'
require 'forwardable'

module Mkpw
  WORDS_FILE = File.join(File.dirname(__FILE__), 'static/words')
end

require_relative 'mkpw/errors'
require_relative 'mkpw/constituents'
require_relative 'mkpw/constituents/alphas'
require_relative 'mkpw/constituents/numbers'
require_relative 'mkpw/constituents/symbols'
require_relative 'mkpw/constituents/words'

module Mkpw
  COMPONENTS = {
    alphas: Alphas.new,
    numbers: Numbers.new,
    symbols: Symbols.new,
    words: Words.new
  }.freeze
end

require_relative 'mkpw/ugly_pass'

class OldMkpw
  attr_reader :words, :nums, :alphas, :symbols, :components
  def initialize(alphas_list: nil, nums_list: nil, symbols_list: nil, words_list: nil)
    @rng = Random.new
    @default_word_list_path = '/usr/share/dict/words'
    @components = {
      alphas: alphas(list: alphas_list),
      nums: nums(list: nums_list),
      words: words(list: words_list),
      symbols: symbols(list: symbols_list)
    }.freeze
  end

  def generate_word_pass(word_qty: 2)
    { seperator: compose.join, words: words.sample(word_qty).map(&:chomp) }
  end

  def compose(width: 2, weights: { nums: 0.5, symbols: 0.5 })
    total = 0
    weights.map { |_set, weight| total += weight }
    weights.map { |set, weight| components[set.to_sym].sample((weight / total) * width) }.shuffle
  end

  # componentes
  def words(list: nil)
    @words ||= prep_words(list: list).freeze
  end

  def nums(list: nil)
    @nums ||= (list || (0..9).to_a).freeze
  end

  def alphas(list: nil)
    @alphas ||= (list || ('a'..'z').to_a + ('A'..'Z').to_a).freeze
  end

  def symbols(list: nil)
    @symbols ||= (list || ',./<>?;:-=_+&*%^#$!@~|'.chars).freeze
  end

  private

  attr_reader :rng
  def prep_words(list: nil)
    list ||= File.readlines(@default_word_list_path).map(&:chomp)
    list.map do |word|
      random_index = rng.rand(0...word.length)
      word[random_index] = word[random_index].upcase
      word
    end
  end
end
