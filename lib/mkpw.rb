#!/usr/bin/env ruby

class Passme
  def initialize
    @word_list = File.readlines('/usr/share/dict/words')
  end
    
  def generate(words=2)
    sep = [randnum, randsymbol].shuffle.join
    (0...words).map do |x|
      out = [randword] 
      if x > 0 then out.unshift(sep) end
      out
    end.flatten
  end

  def randfrom(qty=1, set)
    (0...qty).map { set.sample }.join
  end

  def randword
    randfrom(@word_list).chomp
  end

  def randnum(qty=1)
    randfrom(qty, (0..9).to_a)
  end

  def randalpha(qty=1)
    randfrom(qty, ('a'..'z').to_a + ('A'..'Z').to_a)
  end

  def randsymbol(qty=1)
    randfrom(qty, ',./<>?;:-=_+&*%^#$!@~|'.chars)
  end
end
