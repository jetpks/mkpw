# frozen_string_literal: true

describe Mkpw::UglyPass do
  context 'initialization' do
    subject { described_class }

    it 'freezes the weights' do
      expect(subject.new.weights.frozen?).to be true
    end

    it 'allows setting weights' do
      new_weights = { alphas: 42, symbols: 4 }

      object = subject.new
      expect(object.weights.hash).not_to eq(new_weights.hash)
      object.weights = new_weights
      expect(object.weights.hash).to eq(new_weights.hash)
    end

    it 'allows setting length' do
      object = subject.new(length: 1)
      expect(object.length).to eq(1)
      object.length = 2
      expect(object.length).to eq(2)
    end
  end

  context 'regular operation' do
    subject { described_class.new }

    it 'generates strings with the correct length' do
      expect(subject.generate.length).to eq(subject.length)
      subject.length = 4
      expect(subject.generate.length).to eq(subject.length)
    end

    it 'generates strings with the correct composition' do
      (1..128).each do |new_length|
        subject.length = new_length

        # simple cases
        subject.weights = { alphas: 1 }
        expect(/[^a-zA-Z]/.match?(subject.generate)).to be false
        subject.weights = { numbers: 1 }
        expect(/[^0-9]/.match?(subject.generate)).to be false

        # 2 charsets
        subject.weights = { alphas: 1, numbers: 1 }
        if new_length >= subject.weights.size
          expect(/[a-zA-Z]/.match?(subject.generate)).to be true
          expect(/[0-9]/.match?(subject.generate)).to be true
        end
        expect(/[^a-zA-Z0-9]/.match?(subject.generate)).to be false

        # TODO 3 charsets
      end
    end

    it ''
  end
end
