require_relative "../ruby/board"
require_relative "../ruby/rune"

# class FakeRune
#   attr_accessor :breed, :color

#   def initialize(position, breed, color)
#     @breed = breed
#     @color = color
#     @position = position
#   end

#   def x() @position[0] end
#   def y() @position[1] end
#   def within?(position) true end
#   def size() 10 end
# end

class Board
  attr_reader :runes
end

describe "a board" do
  let(:runes) {
    [Rune.new({ position: [0, 0], breed: "breed1", color: "color1" }),
     Rune.new({ position: [0, 10], breed: "breed2", color: "color1" }),
     Rune.new({ position: [10, 0], breed: "breed1", color: "color2" })]
  }
  let(:board) {
    Board.new(
      { position: [0, 0],
        size: [10, 10],
        runes: runes }
    )
  }

  it "can be drawn" do
    expect(board).to respond_to(:draw)
  end

  it "can be clicked" do
    expect(board).to respond_to(:click)
  end

  it "spreds color to to ajacent runes of the same breed when left clicked" do
    board.click(true, [0, 0])
    expect(runes[0].color).to eq(runes[2].color)
  end

  it "spreds breed to to ajacent runes of the same color when left clicked" do
    board.click(true, [0, 10])
    expect(runes[0].breed).to eq(runes[1].breed)
  end

  it "is clickable when the mouse_position is over it" do
    expect(board).to be_clickable([1, 1])
    expect(board).to_not be_clickable([-1, -1])
  end
end
