require_relative "../ruby/rune"

describe "a rune" do
  let(:rune) { Rune.new([0, 0]) }

  it "can be drawn" do
    expect(rune).to respond_to(:draw)
  end

  it "can be clicked" do
    expect(rune).to respond_to(:click)
  end

  it "has a size that is an int" do
    expect(Rune.size).to be_instance_of(Integer)
  end

  it "can tell if a position is within it" do 
    expect(rune.within?([Rune.size/2,Rune.size/2])).to be true
    expect(rune.within?([Rune.size*2,Rune.size*2])).to be false
  end

  it "can have its breed accessed" do 
    rune.breed = "test"
    expect(rune.breed).to eq("test")
  end

  it "can have its color accessed" do 
    rune.color = "test"
    expect(rune.color).to eq("test")
  end

  it "has an x value that is the space it would occuppy on a grid" do 
    expect(rune.x).to eq(0)
  end

  it "has an y value that is the space it would occuppy on a grid" do 
    expect(rune.y).to eq(0)
  end
end
