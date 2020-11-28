require_relative "../ruby/grid.rb"

describe "A grid" do
  it "can find the quickest path between two points" do
    expect(Grid.new(list: [[true] * 3, [true] * 3, [true] * 3])
      .find_fatest_path([0, 0], [2, 2])).to eq([[0, 0], [1, 1], [2, 2]])
  end

  it "returns the point in the starting and ending points are the same" do
    expect(Grid.new(list: [[true] * 3, [true] * 3, [true] * 3])
      .find_fatest_path([0, 0], [0,0])).to eq([[0, 0]])
  end

  it "can not go over points that are false" do 
    expect(Grid.new(list: [[true] * 3, [false,false,true], [true] * 3])
        .find_fatest_path([0,0],[2,0])).to eq([[0,0],[0,1],[1,2],[2,1],[2,0]])
  end
end
