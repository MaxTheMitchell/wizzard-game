require_relative "../src/gridLazy.rb"
require_relative "../src/hitbox.rb"

describe "A grid" do
  let(:grid) {
    Grid.new(size: [3, 3])
  }

  let(:grid_with_walls) {
    Grid.new({
      size: [3, 3],
      segment_length: 1,
      walls: [Hitbox.new([1, 0], [0, 1])],
    })
  }

  let(:grid_with_no_path) {
    Grid.new({
      size: [3, 3],
      segment_length: 1,
      walls: [Hitbox.new([1, 0], [3, 0])],
    })
  }

  it "exists" do
    grid
  end

  it "can find the quickest path between two points" do
    expect(grid.find_fatest_path([0, 0], [2, 2])).to eq([[0, 0], [1, 1], [2, 2]])
  end

  it "returns the point in the starting and ending points are the same" do
    expect(grid.find_fatest_path([0, 0], [0, 0])).to eq([[0, 0]])
  end

  xit "can navigate through missing positions" do
    expect(grid_with_walls.find_fatest_path([0, 0], [2, 0])).to eq([[0, 0], [0, 1], [1, 2], [2, 1], [2, 0]])
  end

  it "returns an empty list if no path is possible" do
    expect(grid_with_no_path.find_fatest_path([0, 0], [2, 0])).to eq([])
  end
end
