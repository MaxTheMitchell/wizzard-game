require_relative "./color"
require_relative "./image"

class Textbox
  BACKGROUND_IMG_PATH = "assets/button.png"

  def initialize(options = {})
    @width, @height = options[:size]
    @x,@y = options[:position]
    @text = options[:text]
    @color = options[:color] ||= Color.blue
    @background = options[:background] ||= Image.new(path: BACKGROUND_IMG_PATH)
  end

  def draw(mouse_position)
    @background.draw(@x,@y,1,@width,@height,@color)
  end

  def clickable?(mouse_position) false end
end
