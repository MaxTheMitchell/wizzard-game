require_relative "./image"
require_relative "./color"

class Mouse
  SIZE = [25, 25]
  IMG_CLICKABLE = Image.new(path: "assets/imgs/mouse_point.png")
  IMG = Image.new(path: "assets/imgs/mouse.png")
  COLOR = Color.rgba(100, 250, 150)
  Z_INDEX = 10

  def draw(mouse_position, clickable)
    if clickable
      IMG_CLICKABLE.draw(*mouse_position, Z_INDEX, *SIZE, COLOR)
    else
      IMG.draw(*mouse_position, Z_INDEX, *SIZE, COLOR)
    end
  end

  private
end
