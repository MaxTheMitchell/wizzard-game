require_relative "../ruby/window"

describe "a window" do
  it "can have it's screen changed" do
    window = Window.new
    window.current_screen = "test"
  end
end
