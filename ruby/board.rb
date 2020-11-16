require_relative "./rune"
require_relative "./hitbox"

class Board
  def initialize(position, options = {})
    @x = position[0]
    @y = position[1]
    @runes = options[:runes] ||= random_runes(*options[:size])
    @hitbox = Hitbox.new position, [width, height]
  end

  def draw(mouse_position)
    @runes.flatten.each { |rune| rune.draw(@x, @y) }
  end

  def click(left_click, position)
    position = position[0] - @x, position[1] - @y
    if left_click
      spred_color rune_at(position)
    else
      spred_breed rune_at(position)
    end
  end

  def clickable?(mouse_position)
    within? mouse_position
  end

  private

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
    @hitbox.within? position
  end

  def ajacent_runes(rune)
    [get_rune(rune.x - 1, rune.y), get_rune(rune.x + 1, rune.y),
     get_rune(rune.x, rune.y - 1), get_rune(rune.x, rune.y + 1)].filter { |rune| rune != nil }
  end

  def rune_at(position)
    @runes.flatten.find { |rune| rune.within?(position) }
  end

  def get_rune(x, y)
    return nil if x < 0 or y < 0 or x >= @runes.length or y >= @runes[0].length
    @runes[x][y]
  end

  def random_runes(x, y)
    (0..x).map do |row|
      (0..y).map { |col| Rune.new([row * Rune.size, col * Rune.size]) }
    end
  end

  def width
    @runes.length * Rune.size
  end

  def height
    @runes[0].length * Rune.size
  end
end
