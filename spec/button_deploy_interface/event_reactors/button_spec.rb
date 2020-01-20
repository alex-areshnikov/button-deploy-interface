RSpec.describe ButtonDeployInterface::EventReactors::Button do
  subject { described_class.new(state_previous, state_current, [interface_actor]) }

  let(:interface_actor) { proc {} }

  context "when button is pressed" do
    let(:state_previous) { { "button" => "no_button_pressed" } }
    let(:state_current) { { "button" => "select_button_pressed" } }

    let(:expected_data) { { access_granted: nil, finger_id: nil, name: :select, state: :pressed, step: nil } }

    it "calls button pressed" do
      expect(interface_actor).to receive(:call).with(:button, expected_data)
      subject.react
    end
  end

  context "when button is released" do
    let(:state_previous) { { "button" => "deploy_button_pressed" } }
    let(:state_current) { { "button" => "no_button_pressed", "step" => "2", "finger_id" => 1, "access_granted" => false } }

    let(:expected_data) { { access_granted: false, finger_id: 1, name: :deploy, state: :released, step: "2" } }

    it "calls button released" do
      expect(interface_actor).to receive(:call).with(:button, expected_data)
      subject.react
    end
  end

  context "when no previous state" do
    let(:state_previous) { nil }
    let(:state_current) { { "button" => "down_button_pressed", "step" => "3", "finger_id" => 2, "access_granted" => true } }

    let(:expected_data) { { access_granted: true, finger_id: 2, name: :down, state: :pressed, step: "3" } }

    it "calls button pressed" do
      expect(interface_actor).to receive(:call).with(:button, expected_data)
      subject.react
    end
  end
end
