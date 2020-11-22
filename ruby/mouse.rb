require_relative "./image"
require_relative "./color"

class Mouse
  SIZE = [25, 25]
  IMG_PATH = "assets/mouse.png"
  IMG_CLICKABLE = Image.new(path: "assets/mouse_point.png")
  IMG = Image.new(path: "assets/mouse.png")
  COLOR = Color.rgba(100, 250, 150)

  def draw(mouse_position, clickable)
    if clickable
      IMG_CLICKABLE.draw(*mouse_position, 2, *SIZE, COLOR)
    else
      IMG.draw(*mouse_position, 2, *SIZE, COLOR)
    end
  end

  private
end
