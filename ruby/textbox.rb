require_relative "./color"
require_relative "./image"

class Textbox
  BACKGROUND_IMG_PATH = "assets/textbox.png"
  TEXT_SPACING_PERCENT = 0.05

  def initialize(options = {})
    @width, @height = options[:size] ||= [0, 0]
    @x, @y = options[:position] ||= [0, 0]
    @text = options[:text]
    @color = options[:color] ||= Color.rgba 0, 0, 255, 200
    @background = options[:background] ||= Image.new(path: BACKGROUND_IMG_PATH)
    
  end

  def draw(mouse_position, x = @x, y = @y, width = @width, height = @height, color = @color)
    @background.draw(x, y, 1, width, height, color)
    @text.adjust_to_width(width - width * TEXT_SPACING_PERCENT)
    @text.draw({
      x: x + width * TEXT_SPACING_PERCENT,
      y: y + height * TEXT_SPACING_PERCENT,
      height: height / 3,
    })
  end

  def clickable?(mouse_position) false end

  private
end
