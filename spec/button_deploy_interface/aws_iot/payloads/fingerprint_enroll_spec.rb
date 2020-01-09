RSpec.describe ButtonDeployInterface::AwsIot::Payloads::FingerprintEnroll do
  subject { described_class.new(7) }

  let(:expected_payload) { "{\"state\":{\"desired\":{\"fingerprint\":{\"enroll\":true,\"id\":7}}}}" }

  it "composes enroll payload" do
    expect(subject.call).to eq(expected_payload)
  end
end
