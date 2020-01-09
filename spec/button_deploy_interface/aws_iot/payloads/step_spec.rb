RSpec.describe ButtonDeployInterface::AwsIot::Payloads::Step do
  context "with no error" do
    subject { described_class.new(2) }

    let(:expected_payload) { "{\"state\":{\"desired\":{\"step\":2,\"error\":false}}}" }

    it "composes success step payload" do
      expect(subject.call).to eq(expected_payload)
    end
  end

  context "with error" do
    subject { described_class.new(7, error: true) }

    let(:expected_payload) { "{\"state\":{\"desired\":{\"step\":7,\"error\":true}}}" }

    it "composes success step payload" do
      expect(subject.call).to eq(expected_payload)
    end
  end
end
