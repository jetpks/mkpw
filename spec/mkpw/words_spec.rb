describe Mkpw::Words do
  let(:fake_test_words_file) { FIXTURE_DIR.join('files/fake_test_words') }

  context 'initialization' do
    subject { described_class }
    describe '.new' do
      it 'loads words' do
        expect(subject.new.words.length).to be > 0
      end

      it 'loads words from a custom file' do
        expect(subject.new(from_file: fake_test_words_file).words.length).to be > 0
      end

      it 'raises an error when it cannot read the file' do
        expect { subject.new(from_file: 'not-a-file') }.to raise_error(Mkpw::FileUnreadableError)
      end
    end
  end

  context 'regular operation' do
    subject { described_class.new }

    describe '#select' do
      it 'returns a word from the list' do
        word = subject.select.first
        expect(subject.words).to include word
      end

      it 'can return multiple words' do
        words = subject.select(quantity: 2)
        expect(words).to be_instance_of(Array)
        expect(words.length).to eq(2)
      end

      it 'returns words with random characters uppercased' do
        # fake_test_words are all lower case, whereas the regular words
        # list contains words with upper case characters that could skew
        # the results of this test

        w = described_class.new(from_file: fake_test_words_file)
        word = w.select(with_random_upper: true).first
        expect(/[[:upper:]]/.match?(word)).to be true
      end
    end
  end
end