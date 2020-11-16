require_relative "./image"
require_relative "./text"
require_relative "./hitbox"

class Button
  IMAGE_PATH = "assets/button.png"
  WIDTH_PADDING_PERCENT = 0.05

  def initialize position, size, text, color, onclick, options = {}
    @size = size
    @image = Image.new(IMAGE_PATH, size)
    @position = position
    @color = color
    @text = Text.new(text: text)
    @onclick = onclick
    @hover_color = options[:hover_color] ||= @color
    @hitbox = options[:hitbox] ||= Hitbox.new(position, size)
  end

  def draw mouse_position 
    @image.draw(
      *@position,
          1,
      current_dislay_color(mouse_position)
    )
    @text.draw({
      x: text_position[0],
      y: text_position[1],
      width: text_size[0],
      height: text_size[1],
    })
  end

  def click left_click
    @onclick.call
  end

  def clickable? mouse_position
    within? mouse_position
  end

  private

  def current_dislay_color mouse_position 
    return @hover_color if within? mouse_position
    @color
  end

  def within? position 
    @hitbox.within? position
  end

  def text_position image_position = @position
    [image_position[0] + text_size[0] * WIDTH_PADDING_PERCENT,
     image_position[1]]
  end

  def text_size button_size = @size
    [button_size[0].to_f * (1 - WIDTH_PADDING_PERCENT * 2),
     button_size[1]]
  end
end
