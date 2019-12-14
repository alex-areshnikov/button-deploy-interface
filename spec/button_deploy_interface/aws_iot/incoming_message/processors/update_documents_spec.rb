RSpec.describe ButtonDeployInterface::AwsIot::IncomingMessage::Processors::UpdateDocuments do
  subject { described_class.new(raw_payload, []) }

  let(:event_reactor_button) { instance_double ButtonDeployInterface::EventReactors::Button }

  let(:raw_payload) do
    "{\"previous\":{\"state\":{\"reported\":{\"button\":\"no_button_pressed\",\"test_field\":\"some_data\"}}},\"current\":{\"state\":{\"reported\":{\"button\":\"up_button_pressed\",\"test_field\":\"some_data\"}}}}"
  end

  let(:expected_previous_state) do
    {
      "button" => "no_button_pressed",
      "test_field" => "some_data"
    }
  end

  let(:expected_current_state) do
    {
      "button" => "up_button_pressed",
      "test_field" => "some_data"
    }
  end

  it "processes message" do
    expect(ButtonDeployInterface::EventReactors::Button).to receive(:new)
      .with(expected_previous_state, expected_current_state, [])
      .and_return(event_reactor_button)

    expect(event_reactor_button).to receive(:react)

    subject.process
  end
end
