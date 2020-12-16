require_relative "../src/hitbox.rb"

class Hitbox
  def public_lines_intersect?(line_a, line_b)
    lines_intersect?(line_a, line_b)
  end
end

describe "A hitbox" do
  it "exists" do
    Hitbox.new([0, 0], [1, 1])
  end

  it "can tell if a position is within it" do
    hitbox = Hitbox.new([0, 0], [10, 10])
    expect(hitbox.within?([5, 5])).to be true
    expect(hitbox.within?([100, 100])).to be false
  end

  it "can tell if two lines intersect" do
    hitbox = Hitbox.new([0, 0], [10, 10])
    expect(
      hitbox.public_lines_intersect?([[1, 1], [3, 3]], [[1, 4], [2, 1]])
    ).to be true
    expect(
      hitbox.public_lines_intersect?([[1, 1], [3, 3]], [[0, 0], [0, 5]])
    ).to be false
  end

  it "can tell if a line is within itself" do
    hitbox = Hitbox.new([0, 0], [10, 10])
    expect(
      hitbox.line_within?([[1, 1], [3, 3]])
    ).to be true
    expect(
      hitbox.line_within?([[-15, -15], [15, 15]])
    ).to be true
    expect(
      hitbox.line_within?([[15, 15], [12, 12]])
    ).to be false
  end
end
