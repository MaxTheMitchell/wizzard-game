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

  def line_within?(line)
    within?(line[0]) or
    within?(line[1]) or
    to_lines.any? { |l| lines_intersect?(l, line) }
  end

  private

  def to_lines
    [
      [[@x, @y], [end_x, @y]],
      [[@x, @y], [@x, end_y]],
      [[end_x, @y], [end_x, end_y]],
      [[@x, end_y], [end_x, end_y]],
    ]
  end

  def lines_intersect?(line_a, line_b)
    dir1 = direction(line_a[0], line_a[1], line_b[0])
    dir2 = direction(line_a[0], line_a[1], line_b[1])
    dir3 = direction(line_b[0], line_b[1], line_a[0])
    dir4 = direction(line_b[0], line_b[1], line_a[1])
    (dir1 != dir2 and dir3 != dir4) or
    (dir1 == :collinear and on_line?(line_b[0], line_a)) or
    (dir2 == :collinear and on_line?(line_b[1], line_a)) or
    (dir3 == :collinear and on_line?(line_a[0], line_b)) or
    (dir4 == :collinear and on_line?(line_a[1], line_b))
  end

  def direction(point_a, point_b, point_c)
    #  (b.y-a.y)*(c.x-b.x)-(b.x-a.x)*(c.y-b.y)
    val = (point_b[1] - point_a[1]) * (point_c[0] - point_b[0]) - (point_b[0] - point_a[0]) * (point_c[1] - point_b[1])
    if val == 0
      :collinear #0
    elsif val < 0
      :anticlockwise #2
    else
      :clockwise #1
    end
  end

  def on_line?(point, line)
    point[0].between?([line[0][0], line[1][0]].min, [line[0][0], line[1][0]].max) and
      point[1].between?([line[0][1], line[1][1]].min, [line[0][1], line[1][1]].max)
  end

  def within_x_axis?(x)
    x.between?(@x, end_x)
  end

  def within_y_axis?(y)
    y.between?(@y, end_y)
  end

  def end_x
    @x + @width
  end

  def end_y
    @y + @height
  end
end
