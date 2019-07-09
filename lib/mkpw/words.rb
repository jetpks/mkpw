module Mkpw

  # Mkpw::Words supplies groups of random words selected from a file loaded at
  # runtime.
  #
  # @param from_file *optional* File from which to load words
  class Words
    attr_reader :words

    def initialize(from_file: nil)
      load_words_from_file!(from_file || WORDS_FILE)
    end

    # Words#select returns one or more words optionally with a random character
    # in the each word capitalized
    #
    # @param quantity *optional* Number of words to return; defaults to 1
    # @param with_random_upper *optional* When true, capitalizes a random
    #   character in each selected word; defaults to false
    #
    # @return [Array] of selected words
    def select(quantity: 1, with_random_upper: false)
      words.sample(quantity).tap do |selected_words|
        if with_random_upper
          selected_words.each do |word|
            random_upper!(word)
          end
        end
      end
    end

    private

    def load_words_from_file!(file)
      raise Mkpw::FileUnreadableError, file unless File.readable?(file)
      @words = File.readlines(file).map(&:chomp).freeze
    end

    def random_upper!(word)
      random_index = rng.rand(0...word.length)
      word[random_index] = word[random_index].upcase
    end

    def rng
      @rng ||= Random.new
    end
  end
end