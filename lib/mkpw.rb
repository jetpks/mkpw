#!/usr/bin/env ruby

class Mkpw
  attr_accessor :components
  def initialize
    @components = {
      words: File.readlines('/usr/share/dict/words'),
      nums: (0..9).to_a,
      alphas: ('a'..'z').to_a + ('A'..'Z').to_a,
      symbols: ',./<>?;:-=_+&*%^#$!@~|'.chars
    }
    true
  end

  def generate_word_pass(word_qty: 2)
    {seperator: compose.join, words: components[:words].sample(word_qty).map(&:chomp)}
  end

  def compose(width: 2, weights: {nums: 0.5, symbols: 0.5})
    total = 0
    weights.map {|set,weight| total += weight}
    weights.map {|set,weight| components[set].sample((weight / total) * width)}.shuffle
  end
end
