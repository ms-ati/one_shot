RSpec.describe OneShot::ArrayLikeEnumerator do
  describe "#initialize" do
    subject { described_class.new(arg) }

    context "with an Enumerator::Lazy" do
      let(:arg) { [].lazy }
      it { expect { subject }.not_to raise_error }
    end

    context "with *not* Enumerator::Lazy" do
      let(:arg) { [] }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "#[]" do
    subject { instance[index] }
    let(:instance) { described_class.new(enumerator) }
    let(:enumerator) { (0..5).lazy }
  end
end
