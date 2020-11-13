require_relative './image'

class Mouse

  IMG = Image.new("assets/mouse.png")
  SIZE = [25,25]

  def initialize(x,y)
    @x = x
    @y = y
  end

  def draw
    IMG.draw(*position,2,x_scale,y_scale)
  end

  def update
  end

  private

  def x_scale 
    SIZE[0].to_f/IMG.width
  end

  def y_scale 
    SIZE[1].to_f/IMG.height
  end

  def position
    [@x.call, @y.call]
  end
end