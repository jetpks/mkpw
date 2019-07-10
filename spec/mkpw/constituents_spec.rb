describe Mkpw::Constituents do
  let(:basic_set) { %w|a b c| }
  let(:fancy_set) { %w|λ ê a b c 1 2 hippopotamus| }

  context 'initialization' do
    subject { described_class }

    describe '.new' do
      it 'intakes all items in the base_set' do
        expect(subject.new(basic_set).items).to eq(basic_set)
      end

      it 'works with non-ascii items' do
        expect(subject.new(fancy_set).items).to eq(fancy_set)
      end

      it 'freezes the set of characters after initializing' do
        expect(subject.new(basic_set).items.frozen?).to be true
      end

      it 'raises an error when passed non-strings' do
        expect { subject.new([0]) }.to raise_error(Mkpw::NotAString)
        expect { subject.new([[]]) }.to raise_error(Mkpw::NotAString)
        expect { subject.new([String]) }.to raise_error(Mkpw::NotAString)
        expect { subject.new([Forwardable]) }.to raise_error(Mkpw::NotAString)
      end
    end
  end

  context 'regular operation' do
    subject { described_class.new(fancy_set) }

    describe '#select_random' do
      it 'returns an item from @items' do
        expect(subject.items).to include(subject.select_random.first)
      end

      it 'returns only one item by default' do
        expect(subject.select_random).to be_instance_of(Array)
        expect(subject.select_random.length).to eq(1)
      end

      it 'returns multiple items when asked' do
        expect(subject.select_random(quantity: 2)).to be_instance_of(Array)
        expect(subject.select_random(quantity: 2).length).to eq(2)
      end

      ##
      # There's a 0.00305% chance this test fails during normal operation,
      # provided there are 8 items in :fancy_set. That chance can be reduced by
      # increasing the quantity we select or the number of items in fancy_set
      #
      it 'returns a distinct random set of items on each call' do
        first = subject.select_random(quantity: 5).join
        second = subject.select_random(quantity: 5).join

        expect(first).not_to eq(second)
      end
    end
  end
end