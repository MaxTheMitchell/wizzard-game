require_relative "./image"

class Mouse
  SIZE = [25, 25]
  IMG = Image.new("assets/mouse.png",SIZE)
  
  def initialize(x, y)
    @x = x
    @y = y
  end

  def draw
    IMG.draw(*position, 2)
  end
  
  def click
    position
  end

  private

  def position
    [@x.call, @y.call]
  end
end
