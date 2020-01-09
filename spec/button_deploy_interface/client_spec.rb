RSpec.describe ButtonDeployInterface::Client do
  subject { described_class.new(certificate_path, private_key_path) }

  let(:certificate_path) { "certificate_path" }
  let(:private_key_path) { "private_key_path" }

  let(:connector) { instance_double(ButtonDeployInterface::AwsIot::Connector) }
  let(:update_publisher) { instance_double(ButtonDeployInterface::AwsIot::UpdatePublisher) }
  let(:thing_topics) { instance_double(ButtonDeployInterface::AwsIot::ThingTopics) }
  let(:steps_manager) { instance_double(ButtonDeployInterface::AwsIot::Steps::Manager) }

  before do
    expect(ButtonDeployInterface::AwsIot::Connector).to receive(:new).and_return(connector)
    expect(ButtonDeployInterface::AwsIot::UpdatePublisher).to receive(:new).and_return(update_publisher)
    expect(ButtonDeployInterface::AwsIot::ThingTopics).to receive(:new).and_return(thing_topics)
    expect(ButtonDeployInterface::AwsIot::Steps::Manager).to receive(:new).and_return(steps_manager)
  end

  it "does setup" do
    expect(connector).to receive(:connect)
    expect(connector).to receive(:connected?).and_return(true)
    expect(connector).to receive(:subscribe)
    expect(connector).to receive(:register_on_message_callback)
    expect(thing_topics).to receive(:update_documents)
    subject.setup
  end

  it "calls set step" do
    expect(steps_manager).to receive(:step).with(2)

    subject.step(2)
  end

  context "fingerprint" do
    let(:payload_builder) { instance_double(ButtonDeployInterface::AwsIot::Payloads::FingerprintEnroll) }

    it "calls fingerprint enroll" do
      expect(ButtonDeployInterface::AwsIot::Payloads::FingerprintEnroll).to receive(:new).with(6).and_return(payload_builder)
      expect(payload_builder).to receive(:call).and_return("payload")
      expect(update_publisher).to receive(:call).with("payload")

      subject.fingerprint_enroll(6)
    end
  end
end
