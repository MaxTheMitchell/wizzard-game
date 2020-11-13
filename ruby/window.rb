require "gosu"
require_relative "./board"
require_relative "./mouse"

class Window < Gosu::Window
  MOUSE_ID = 256

  def initialize
    super 1000, 1000, update_interval: 10
    self.caption = "game prototype"
    @board = Board.new(0, 0, size: [10, 10])
    @mouse = Mouse.new(
      method(:mouse_x),
      method(:mouse_y)
    )
  end

  def click
    position = @mouse.click
    if @board.within?(position)
      @board.click(position)
    end
  end

  def button_down(id)
    if id == MOUSE_ID
      click
    end
  end

  private

  def update
    @mouse.update
  end

  def draw
    @board.draw
    @mouse.draw
  end
end
