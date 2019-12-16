RSpec.describe ButtonDeployInterface::AwsIot::Steps::Manager do
  subject { described_class.new(connector) }

  let(:connector) { instance_double(ButtonDeployInterface::AwsIot::Connector, connected?: true) }
  let(:composer) { instance_double(ButtonDeployInterface::AwsIot::Steps::Composer) }

  it "sets step" do
    expect(ButtonDeployInterface::AwsIot::Steps::Composer).to receive(:new).with(2).and_return(composer)
    expect(composer).to receive(:call).and_return("payload")
    expect(connector).to receive(:publish).with("$aws/things/DeployButton/shadow/update", "payload")
    subject.set_step(2)
  end
end
