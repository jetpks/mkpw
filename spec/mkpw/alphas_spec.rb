describe Mkpw::Alphas do
  context 'initialization' do
    subject { described_class }
    describe '.new' do
      it 'loads the default alphas with no input' do
        expect(subject.new.alphas).to be_instance_of(Array)
        expect(subject.new.alphas.length).to be == 52
      end

      it 'adds characters to the set when asked' do
        expect(subject.new(add_chars: ['λ']).alphas).to include 'λ'
      end

      it 'uses only the provided characters when asked' do
        alphas = subject.new(only_chars: ['λ', 'ê']).alphas
        expect(alphas.length).to eq(2)
        expect(alphas).to include ('ê')
        expect(alphas).not_to include ('a')
      end

      it 'freezes the set of characters after initializing' do
        expect(subject.new.alphas.frozen?).to be true
      end
    end
  end

  context 'regular operation' do
    subject { described_class.new }
    describe '#select' do
      it 'returns one character by default' do
        expect(subject.select).to be_instance_of(Array)
        expect(subject.select.length).to eq(1)
      end

      it 'returns multiple characters when asked' do
        expect(subject.select(quantity: 2)).to be_instance_of(Array)
        expect(subject.select(quantity: 2).length).to eq(2)
      end

      it 'returns a random set of characters each time' do
        first = subject.select(quantity: 3).join
        second = subject.select(quantity: 3).join

        expect(first).not_to eq(second)
      end
    end
  end
end