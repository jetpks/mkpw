describe Mkpw::Alphas do
  let(:default_set) { Mkpw::DEFAULT_ALPHAS }

  context 'initialization' do
    subject { described_class }
    describe '.new' do
      it 'loads the default items with no input' do
        expect(subject.new.items).to be_instance_of(Array)
        expect(subject.new.items).to eq(default_set)
      end
    end
  end
end
