require_relative "./rune"

class Board
  def initialize(x = 0, y = 0, options = {})
    @x = x
    @y = y
    @runes = options[:runes] ||= random_runes(*options[:size])
  end

  def draw
    @runes.flatten.each { |rune| rune.draw(@x, @y) }
  end

  def click(position, left_click)
    position = position[0] - @x, position[1] - @y
    if left_click
      spred_color @runes.flatten.find { |rune| rune.within?(position) }
    else
      spred_breed @runes.flatten.find { |rune| rune.within?(position) }
    end
  end

  def spred_color(rune, spred_runes = [])
    spred_runes << rune
    ajacent_runes(rune).filter { |r| rune.breed == r.breed and not spred_runes.include?(r) }.each do |r|
      r.color = rune.color
      spred_color(r, spred_runes)
    end
  end

  def spred_breed(rune, spred_runes = [])
    spred_runes << rune
    ajacent_runes(rune).filter { |r| rune.color == r.color and not spred_runes.include?(r) }.each do |r|
      r.breed = rune.breed
      spred_breed(r, spred_runes)
    end
  end

  def within?(position)
    within_x_axis?(position[0]) and within_y_axis?(position[1])
  end

  def ajacent_runes(rune)
    [get_rune(rune.x - 1, rune.y), get_rune(rune.x + 1, rune.y),
     get_rune(rune.x, rune.y - 1), get_rune(rune.x, rune.y + 1)].filter { |rune| rune != nil }
  end

  private

  def get_rune(x, y)
    return nil if x < 0 or y < 0 or x >= @runes.length or y >= @runes[0].length
    @runes[x][y]
  end

  def random_runes(x, y)
    (0..x).map do |row|
      (0..y).map { |col| Rune.new(row, col) }
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
