require "gosu"
require_relative "./mouse"
require_relative "./screens"

class Window < Gosu::Window
  LEFT_MOUSE_ID = 256
  RIGHT_MOUSE_ID = 258
  ESCAPE = 41
  SIZE = 1920, 1080

  attr_writer :current_screen

  def initialize
    super(*SIZE, { update_interval: 10, fullscreen: true })
    self.caption = "game prototype"
    @current_screen = Screens.new(SIZE, self).graduation
    @mouse = Mouse.new
  end

  private

  def click(left_mouse, mouse_position)
    @current_screen.click(left_mouse, mouse_position)
  end

  def draw
    @mouse.draw mouse_position, mouse_over_clickable?(mouse_position)
    @current_screen.draw mouse_position
  end

  def button_down(id)
    click(true, mouse_position) if id == LEFT_MOUSE_ID
    click(false, mouse_position) if id == RIGHT_MOUSE_ID
    close! if id == ESCAPE
  end

  def mouse_position
    [mouse_x, mouse_y]
  end

  def mouse_over_clickable?(mouse_position)
    @current_screen.over_clickable? mouse_position
  end
end
