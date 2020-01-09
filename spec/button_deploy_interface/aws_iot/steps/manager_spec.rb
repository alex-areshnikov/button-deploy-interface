RSpec.describe ButtonDeployInterface::AwsIot::Steps::Manager do
  subject { described_class.new(publisher) }

  let(:publisher) { instance_double(ButtonDeployInterface::AwsIot::UpdatePublisher) }
  let(:payload_builder) { instance_double(ButtonDeployInterface::AwsIot::Payloads::Step) }

  it "sets step" do
    expect(ButtonDeployInterface::AwsIot::Payloads::Step).to receive(:new).with(2, false).and_return(payload_builder)
    expect(payload_builder).to receive(:call).and_return("payload")
    expect(publisher).to receive(:call).with("payload")
    subject.step(2)
  end
end
