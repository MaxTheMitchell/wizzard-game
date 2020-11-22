require_relative "./image"
require_relative "./color"

class Mouse
  SIZE = [25, 25]
  IMG = Image.new(path: "assets/mouse.png")

  def draw(mouse_position)
    IMG.draw(*mouse_position, 2,*SIZE,Color.rgba(100,250,150))
  end

  private

end
