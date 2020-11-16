require_relative "./image"

class Mouse
  SIZE = [25, 25]
  IMG = Image.new("assets/mouse.png",SIZE)
  
  def initialize
  end

  def draw(mouse_position)
    IMG.draw(*mouse_position, 2)
  end

  private

end
