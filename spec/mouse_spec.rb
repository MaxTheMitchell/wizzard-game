require_relative "../src/mouse"

describe "a Mosue" do
  it "can be drawn" do
    expect(Mouse.new).to respond_to(:draw)
  end
end
