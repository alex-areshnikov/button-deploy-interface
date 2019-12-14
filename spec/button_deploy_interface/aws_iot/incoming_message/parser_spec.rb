RSpec.describe ButtonDeployInterface::AwsIot::IncomingMessage::Parser do
  subject { described_class.new(topic, message, []) }

  let(:message) { "Message" }

  let(:unrecognized_topic_processor) { instance_double(ButtonDeployInterface::AwsIot::IncomingMessage::Processors::Base) }
  let(:update_documents_topic_processor) { instance_double(ButtonDeployInterface::AwsIot::IncomingMessage::Processors::UpdateDocuments) }

  context "when topic is unrecognized" do
    let(:topic) { "unrecognized/topic" }

    it "calls Unrecognized processor" do
      expect(ButtonDeployInterface::AwsIot::IncomingMessage::Processors::Base).to receive(:new).and_return(unrecognized_topic_processor)
      expect(unrecognized_topic_processor).to receive(:process)
      subject.process
    end
  end

  context "when topic is DeployButton update/documents" do
    let(:topic) { "$aws/things/DeployButton/shadow/update/documents" }

    it "calls UpdateDocuments processor" do
      expect(ButtonDeployInterface::AwsIot::IncomingMessage::Processors::UpdateDocuments).to receive(:new).and_return(update_documents_topic_processor)
      expect(update_documents_topic_processor).to receive(:process)
      subject.process
    end
  end
end
