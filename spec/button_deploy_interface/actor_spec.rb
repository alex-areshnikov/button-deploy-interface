RSpec.describe ButtonDeployInterface::Actor do
  subject { described_class.new }

  let(:button_name) { "Button 1" }

  it "#button_pressed" do
    subject.button_pressed(button_name)
  end

  it "#button_released" do
    subject.button_released(button_name)
  end
end
