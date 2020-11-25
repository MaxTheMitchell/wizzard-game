require_relative "./color"
require_relative "./image"

class Textbox
  BACKGROUND_IMG_PATH = "assets/textbox.png"
  TEXT_SPACING_PERCENT = 0.07

  attr_reader :color

  def initialize(options = {})
    @width, @height = options[:size] ||= [0, 0]
    @x, @y = options[:position] ||= [0, 0]
    @text = options[:text]
    @color = options[:color] ||= Color.rgba 0, 0, 255, 200
    @background = options[:background] ||= Image.new(path: BACKGROUND_IMG_PATH)
    @drawn_text_length = options[:drawn_text_length] ||= 0
  end

  def draw(mouse_position, x = @x, y = @y, width = @width, height = @height, color = @color)
    @background.draw(x, y, 1, width, height, color)
    @text.adjust_to_width(width - width * TEXT_SPACING_PERCENT * 2, @text.text[..@drawn_text_length]).draw({
      x: x + width * TEXT_SPACING_PERCENT,
      y: y + height * TEXT_SPACING_PERCENT,
      height: height / 3,
    })
    @drawn_text_length += 1
  end

  def clickable?(mouse_position) false end

  def is_fully_drawn?
    @drawn_text_length >= text_content.length
  end

  def display_all_text
    @drawn_text_length = text_content.length
  end

  private

  def text_content
    @text.text
  end
end
