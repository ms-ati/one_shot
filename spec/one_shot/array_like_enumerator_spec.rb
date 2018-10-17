RSpec.describe OneShot::ArrayLikeEnumerator do
  subject { instance }

  let(:instance) { described_class.new(enumerator) }

  let(:enumerator) { [].lazy }

  describe "#[]" do
    subject { instance[index] }
    let(:enumerator) { (0..5).lazy }
  end

  #
  # TODO: Generalize below specs as 'it_behaves_like "an_enumerator_decorator"'
  #
  describe "#initialize" do
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
    subject { instance.private_methods.include?(:__setobj__) }

    it "is a private method" do
      is_expected.to be true
    end
  end
end
