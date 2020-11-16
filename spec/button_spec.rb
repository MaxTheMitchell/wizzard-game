require_relative "../ruby/button.rb"

describe "A button" do
  let(:button) { Button.new([0, 0], [10, 10], "test", 0, ->{return "test"}) }

  it "can be drawn" do
    expect(button).to respond_to(:draw)
  end

  it "can be clicked if the mouse is over it" do 
    expect(button).to be_clickable([5,5])
    expect(button).to_not be_clickable([15,15])
  end

  it "calls onclick function when it is clicked" do 
    expect(button.click).to eq("test")
  end
end
