require_relative "./image"
require_relative "./button"
require_relative "./color"

class TitleScreen
  BACKGROUND_PATH = "assets/title_screen.jpg"

  def initialize(size, window)
    @background = Image.new(BACKGROUND_PATH, size)
    @window = window
    @buttons = [
      Button.new(
        [size[0] * 0.7, size[1] * 0.3],
        [size[0] * 0.2, size[1] * 0.1],
        "Start New Game",
        Color.rgba(255, 0, 255),
        method(:start_new_game),
        hover_color: Color.rgba(255, 100, 255),
      ),
    ]
  end

  def draw(mouse_position)
    @background.draw(0, 0, 0)
    @buttons.each { |b| b.draw(mouse_position) }
  end

  def click(left_mouse, mouse_position)
    @buttons.each { |b| b.click left_mouse }
  end

  def start_new_game
  end
end
