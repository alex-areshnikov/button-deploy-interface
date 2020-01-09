RSpec.describe ButtonDeployInterface::AwsIot::Payloads::Desired do
  let(:expected_payload) { "{\"state\":{\"desired\":\"inner\"}}" }

  it "composes enroll payload" do
    expect(described_class.build { "inner" }).to eq(expected_payload)
  end
end
