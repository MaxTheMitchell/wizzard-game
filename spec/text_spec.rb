require_relative "../src/text.rb"

describe "Text" do
  it "can be draw" do
    expect(Text.new).to respond_to(:draw)
  end
end
