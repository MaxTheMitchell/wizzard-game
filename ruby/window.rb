require "gosu"
require_relative "./mouse"
require_relative "./titleScreen"

class Window < Gosu::Window
  LEFT_MOUSE_ID = 256
  RIGHT_MOUSE_ID = 258
  SIZE = 1500, 1000

  attr_writer :current_screen

  def initialize
    super(*SIZE, update_interval: 10)
    self.caption = "game prototype"
    @current_screen = TitleScreen.new(SIZE, self)
    @mouse = Mouse.new
  end

  private

  def click(left_mouse, mouse_position)
    @current_screen.click(left_mouse, mouse_position)
  end

  def draw
    @mouse.draw mouse_position
    @current_screen.draw mouse_position
  end

  def button_down(id)
    click(true, mouse_position) if id == LEFT_MOUSE_ID
    click(false, mouse_position) if id == RIGHT_MOUSE_ID
    # puts id
  end

  def mouse_position
    [mouse_x, mouse_y]
  end
end
