require_relative "./color"
require_relative "./image"

class Textbox
  BACKGROUND_IMG_PATH = "assets/button.png"
  TEXT_SPACING_PERCENT = 0.05

  def initialize(options = {})
    @width, @height = options[:size]
    @x, @y = options[:position]
    @text = options[:text]
    @color = options[:color] ||= Color.rgba 0, 0, 255, 100
    @background = options[:background] ||= Image.new(path: BACKGROUND_IMG_PATH)
  end

  def draw(mouse_position)
    @background.draw(@x, @y, 1, @width, @height, @color)
    @text.draw({
      x: @x + @width * TEXT_SPACING_PERCENT,
      y: @y + @height * TEXT_SPACING_PERCENT,
    })
  end

  def clickable?(mouse_position) false end
end
