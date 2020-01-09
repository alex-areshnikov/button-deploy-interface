RSpec.describe ButtonDeployInterface::AwsIot::UpdatePublisher do
  subject { described_class.new(connector) }

  let(:connector) { instance_double(ButtonDeployInterface::AwsIot::Connector, connected?: true) }
  let(:thing_topics) { instance_double(ButtonDeployInterface::AwsIot::ThingTopics) }

  before do
    expect(ButtonDeployInterface::AwsIot::ThingTopics).to receive(:new).and_return(thing_topics)
    expect(thing_topics).to receive(:update).and_return("update_topic")
    expect(connector).to receive(:publish).with("update_topic", "payload")
  end

  it "publishes to update topic" do
    subject.call("payload")
  end
end
