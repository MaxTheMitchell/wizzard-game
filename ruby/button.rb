require_relative "./image"
require_relative "./text"

class Button
  IMAGE_PATH = "assets/button.png"
  WIDTH_PADDING_PERCENT = 0.05

  def initialize(position, size, text, color)
    @size = size
    @image = Image.new(IMAGE_PATH, size)
    @position = position
    @color = color
    @text = Text.new(text: text)
  end

  def draw
    @image.draw(*@position, 1, @color)
    @text.draw({
      x: text_position[0],
      y: text_position[1],
      width: text_size[0],
      height: text_size[1]
    })
  end

  private

  def text_position(image_position = @position)
    [image_position[0] + text_size[0] * WIDTH_PADDING_PERCENT,
     image_position[1]]
  end

  def text_size(button_size = @size)
    [button_size[0].to_f * (1 - WIDTH_PADDING_PERCENT*2),
     button_size[1]]
  end
end
