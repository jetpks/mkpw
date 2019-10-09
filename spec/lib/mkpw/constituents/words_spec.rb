# frozen_string_literal: true

describe Mkpw::Words do
  let(:fake_test_words_file) { FIXTURE_DIR.join('files/fake_test_words') }
  let(:default_words_count) { 235_886 }

  context 'initialization' do
    subject { described_class }
    describe '.new' do
      it 'loads the default set of words words' do
        expect(subject.new.items.length).to be == default_words_count
      end

      it 'loads words from a custom file' do
        expect(subject.new(from_file: fake_test_words_file).items.length).to be > 0
        expect(subject.new(from_file: fake_test_words_file).items.length).to be < default_words_count
      end

      it 'raises an error when it cannot read the supplied file' do
        expect { subject.new(from_file: 'not-a-file') }.to raise_error(Mkpw::FileUnreadableError)
      end
    end
  end

  context 'regular operation' do
    subject { described_class.new }

    describe '#select_random' do
      it 'can returns words with random characters uppercased' do
        # fake_test_words are all lower case, whereas the regular words
        # list contains words with upper case characters that could skew
        # the results of this test

        w = described_class.new(from_file: fake_test_words_file)
        word = w.select_random(with_random_upper: true).first
        expect(/[[:upper:]]/.match?(word)).to be true
      end
    end
  end
end
