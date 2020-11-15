require "gosu"
require_relative "./board"
require_relative "./mouse"
require_relative "./titleScreen"
require_relative "./button"

class Window < Gosu::Window
  LEFT_MOUSE_ID = 256
  RIGHT_MOSUE_ID = 258
  SIZE = 1500, 1000

  def initialize
    super(*SIZE, update_interval: 10)
    self.caption = "game prototype"
    @board = Board.new([750, 150], size: [10, 10])
    @mouse = Mouse.new(
      method(:mouse_x),
      method(:mouse_y)
    )
    @button = Button.new([100,100],[500,300],"foo",Gosu::Color::RED.dup)
    @button1= Button.new([100,600],[500,300],"This is a lot of text... ok???",Gosu::Color::GREEN.dup)
    @titleScreen = TitleScreen.new(SIZE)
  end

  def click(left)
    position = @mouse.click
    @board.click(position, left) if @board.within?(position)
  end

  def button_down(id)
    click(true) if id == LEFT_MOUSE_ID
    click(false) if id == RIGHT_MOSUE_ID
    # puts id
  end

  private

  def draw
    @titleScreen.draw
    @board.draw
    @mouse.draw
    @button.draw
    @button1.draw
  end
end
