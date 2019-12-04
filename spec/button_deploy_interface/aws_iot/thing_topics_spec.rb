RSpec.describe ButtonDeployInterface::AwsIot::ThingTopics do
  subject { described_class.new(thing_name: thing_name) }

  let(:thing_name) { "ThingName" }

  its(:update) { is_expected.to eq("$aws/things/ThingName/shadow/update") }
  its(:update_accepted) { is_expected.to eq("$aws/things/ThingName/shadow/update/accepted") }
  its(:update_documents) { is_expected.to eq("$aws/things/ThingName/shadow/update/documents") }
  its(:update_rejected) { is_expected.to eq("$aws/things/ThingName/shadow/update/rejected") }
  its(:get) { is_expected.to eq("$aws/things/ThingName/shadow/get") }
  its(:get_accepted) { is_expected.to eq("$aws/things/ThingName/shadow/get/accepted") }
  its(:get_rejected) { is_expected.to eq("$aws/things/ThingName/shadow/get/rejected") }
  its(:delete) { is_expected.to eq("$aws/things/ThingName/shadow/delete") }
  its(:delete_accepted) { is_expected.to eq("$aws/things/ThingName/shadow/delete/accepted") }
  its(:delete_rejected) { is_expected.to eq("$aws/things/ThingName/shadow/delete/rejected") }
end
