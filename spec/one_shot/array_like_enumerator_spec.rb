require_relative "enumerator_decorator_shared_examples"

RSpec.describe OneShot::ArrayLikeEnumerator do
  subject(:instance) { described_class.new(enumerator) }
  let(:enumerator) { [].lazy }

  describe "#[]" do
    subject { super()[index] }
    let(:enumerator) { ("a".."z").lazy }

    context "with negative index" do
      let(:index) { -1 }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "#inspect" do
    subject { super().inspect }
    it { is_expected.to start_with("#<ArrayLikeEnumerator") }
  end

  it_behaves_like "an_enumerator_decorator"
end
