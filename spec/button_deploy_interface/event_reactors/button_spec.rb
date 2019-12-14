RSpec.describe ButtonDeployInterface::EventReactors::Button do
  subject { described_class.new(state_previous, state_current, [interface_actor]) }

  let(:interface_actor) { proc {} }

  context "when button is pressed" do
    let(:state_previous) { { "button" => "no_button_pressed" } }
    let(:state_current) { { "button" => "select_button_pressed" } }

    let(:expected_data) { { name: :select, state: :pressed } }

    it "calls button pressed" do
      expect(interface_actor).to receive(:call).with(:button, expected_data)
      subject.react
    end
  end

  context "when button is released" do
    let(:state_previous) { { "button" => "deploy_button_pressed" } }
    let(:state_current) { { "button" => "no_button_pressed" } }

    let(:expected_data) { { name: :deploy, state: :released } }

    it "calls button released" do
      expect(interface_actor).to receive(:call).with(:button, expected_data)
      subject.react
    end
  end

  context "when no previous state" do
    let(:state_previous) { nil }
    let(:state_current) { { "button" => "down_button_pressed" } }

    let(:expected_data) { { name: :down, state: :pressed } }

    it "calls button pressed" do
      expect(interface_actor).to receive(:call).with(:button, expected_data)
      subject.react
    end
  end
end
