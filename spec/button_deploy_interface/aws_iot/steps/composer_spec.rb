RSpec.describe ButtonDeployInterface::AwsIot::Steps::Composer do
  subject { described_class.new(2) }

  let(:expected_payload) { "{\"state\":{\"desired\":{\"step\":2}}}" }

  it "composes payload" do
    expect(subject.call).to eq(expected_payload)
  end
end
