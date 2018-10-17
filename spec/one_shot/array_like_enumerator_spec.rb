require_relative "enumerator_decorator_shared_examples"

RSpec.describe OneShot::ArrayLikeEnumerator do
  subject(:instance) { described_class.new(enumerator) }
  let(:enumerator) { [].lazy }

  describe "#[]" do
    subject { super()[index] }
    let(:enumerator) { (0..5).lazy }

    context "with negative index" do
      let(:index) { -1 }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  it_behaves_like "an_enumerator_decorator"
end
