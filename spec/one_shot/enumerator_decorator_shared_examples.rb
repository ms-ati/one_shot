RSpec.shared_examples "an_enumerator_decorator" do
  describe "#initialize" do
    subject { described_class.new(enumerator) }

    context "with an Enumerator::Lazy" do
      let(:enumerator) { [].lazy }
      it { expect { subject }.not_to raise_error }
    end

    context "with *not* Enumerator::Lazy" do
      let(:enumerator) { [] }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "#__setobj__" do
    subject do
      described_class.new([].lazy).private_methods.include?(:__setobj__)
    end

    it "is a private method" do
      is_expected.to be true
    end
  end
end
