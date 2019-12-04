RSpec.describe ButtonDeployInterface::Client do
  subject { described_class.new(certificate_path: certificate_path, private_key_path: private_key_path) }

  let(:certificate_path) { "certificate_path" }
  let(:private_key_path) { "private_key_path" }

  let(:connector) { instance_double(ButtonDeployInterface::AwsIot::Connector)}
  let(:thing_topics) { instance_double(ButtonDeployInterface::AwsIot::ThingTopics)}

  before do
    expect(ButtonDeployInterface::AwsIot::Connector).to receive(:new).and_return(connector)
    expect(ButtonDeployInterface::AwsIot::ThingTopics).to receive(:new).and_return(thing_topics)
  end

  it "does setup" do
    expect(connector).to receive(:connect)
    expect(connector).to receive(:connected?).and_return(true)
    expect(connector).to receive(:subscribe)
    expect(thing_topics).to receive(:update_documents)
    subject.setup
  end

end
