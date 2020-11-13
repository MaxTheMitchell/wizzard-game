require_relative "./rune"

class Board
  def initialize(x = 0, y = 0, options = {})
    @x = x
    @y = y
    @runes = options[:runes] ||= random_runes(*options[:size])
  end

  def draw
    @runes.each do |row|
      row.each { |rune| rune.draw }
    end
  end

  def update
  end

  def click(position)
    @runes.flatten.find { |rune| rune.within?(position) }.click(position)
  end

  def within?(position)
    within_x_axis?(position[0]) and within_y_axis?(position[1])
  end

  private

  def random_runes(x, y)
    (0..x).map do |row|
      (0..y).map { |col| Rune.new(row * Rune.size + @x, col * Rune.size + @y) }
    end
  end

  def within_x_axis?(x)
    x > @x and x < end_x
  end

  def within_y_axis?(y)
    y > @y and y < end_y
  end

  def end_x
    @x + width
  end

  def end_y
    @y + height
  end

  def width
    @runes.length * Rune.size
  end

  def height
    @runes[0].length * Rune.size
  end
end
