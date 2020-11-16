require_relative "../ruby/board"
require_relative "../ruby/rune"

class FakeRune
  attr_accessor :breed, :color

  def initialize(position, breed, color)
    @breed = breed
    @color = color
    @position = position
  end

  def x() @position[0] end
  def y() @position[1] end
  def within?(position) true end
end

class Board
  attr_reader :runes
end

describe "a board" do
  let(:board) { Board.new [0, 0], size: [10, 10] }

  it "can be drawn" do
    expect(board).to respond_to(:draw)
  end

  it "can be clicked" do
    expect(board).to respond_to(:click)
  end

  it "spreds color to to ajacent runes of the same breed when left clicked" do
    board.runes[0][0].breed = "test_breed"
    board.runes[0][1].breed = "test_breed"
    board.runes[0][0].color = "color1"
    board.runes[0][1].color = "color2"
    board.click(true,[1,1])
    expect(board.runes[0][0].color).to eq(board.runes[0][1].color)
  end

  it "spreds breed to to ajacent runes of the same color when left clicked" do
    board.runes[0][0].breed = "breed1"
    board.runes[0][1].breed = "breed2"
    board.runes[0][0].color = "test_color"
    board.runes[0][1].color = "test_color"
    board.click(false,[1,1])
    expect(board.runes[0][0].breed).to eq(board.runes[0][1].breed)
  end

  it "is clickable when the mouse_position is over it" do
    expect(board).to be_clickable([1, 1])
    expect(board).to_not be_clickable([-1, -1])
  end
end
