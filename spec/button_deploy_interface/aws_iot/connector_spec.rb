RSpec.describe ButtonDeployInterface::AwsIot::Connector do
  subject { described_class.new(certificate_path: certificate_path, private_key_path: private_key_path) }

  let(:certificate_path) { "certificate_path" }
  let(:private_key_path) { "private_key_path" }
  let(:mqtt_client) { instance_double(PahoMqtt::Client) }

  before do
    expect(PahoMqtt::Client).to receive(:new).and_return(mqtt_client)
  end

  context "with mqtt setup" do
    before do
      expect(mqtt_client).to receive(:ssl=).with(true)
      expect(mqtt_client).to receive(:config_ssl_context).with(certificate_path, private_key_path)
      expect(mqtt_client).to receive(:on_connack=)
      expect(mqtt_client).to receive(:on_suback)
      expect(mqtt_client).to receive(:on_message)
      expect(mqtt_client).to receive(:connect)
    end

    it "connects" do
      subject.connect
    end
  end

  it "subscribes" do
    expect(mqtt_client).to receive(:subscribe).with(["topic", 0])
    subject.subscribe("topic")
  end

  it "publishes" do
    expect(mqtt_client).to receive(:publish).with("topic", "payload")
    subject.publish("topic", "payload")
  end

  its(:connected?) { is_expected.to be_falsey}
end
