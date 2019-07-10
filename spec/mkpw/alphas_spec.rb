describe Mkpw::Alphas do
  context 'initialization' do
    subject { described_class }
    describe '.new' do
      it 'loads the default items with no input' do
        expect(subject.new.items).to be_instance_of(Array)
        expect(subject.new.items).to eq(Mkpw::DEFAULT_ALPHAS)
      end

      it 'adds characters to the set when asked' do
        expect(subject.new(add: ['λ']).items).to include 'λ'
        expect(subject.new(add: ['λ']).items).not_to eq(Mkpw::DEFAULT_ALPHAS)
      end

      it 'uses only the provided characters when asked' do
        items = subject.new(only: ['λ', 'ê']).items
        expect(items.length).to eq(2)
        expect(items).to include ('ê')
        expect(items).not_to include ('a')
        expect(items).not_to eq(Mkpw::DEFAULT_ALPHAS)
      end

      it 'freezes the set of characters after initializing' do
        expect(subject.new.items.frozen?).to be true
      end
    end
  end
end