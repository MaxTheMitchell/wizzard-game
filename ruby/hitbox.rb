class Hitbox
  def initialize(position, size)
    @x = position[0]
    @y = position[1]
    @width = size[0]
    @height = size[1]
  end

  def within?(position)
    within_x_axis?(position[0]) and within_y_axis?(position[1])
  end

  private

  def within_x_axis?(x)
    x >= @x and x <= end_x
  end

  def within_y_axis?(y)
    y >= @y and y <= end_y
  end

  def end_x
    @x + @width
  end

  def end_y
    @y + @height
  end
end
