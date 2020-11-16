require_relative "../ruby/hitbox.rb"

describe "A hitbox" do
  it "exists" do
    Hitbox.new([0, 0], [1, 1])
  end

  it "can tell if a position is within it" do
    hitbox = Hitbox.new([0, 0], [10, 10])
    expect(hitbox.within?([5, 5])).to be true
    expect(hitbox.within?([100, 100])).to be false
  end
end
