require_relative "enumerator_decorator_shared_examples"

RSpec.describe OneShot::ArrayLikeEnumerator do
  subject { instance }
  let(:instance) { described_class.new(enumerator) }
  let(:enumerator) { [].lazy }

  describe "#[]" do
    subject { instance[index] }
    let(:enumerator) { (0..5).lazy }
  end

  it_behaves_like "an_enumerator_decorator"
end
