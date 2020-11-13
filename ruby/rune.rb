require_relative "./image"

class Rune
  attr_accessor :type

  RUNE_IMGS = Image.load_tiles("assets/symbols.png", 100, 100)
  SIZE = 50

  def initialize(x = 0, y = 0, type = Rune.random_rune, color = Rune.random_color)
    @x = x
    @y = y
    @type = type
    @color = color
  end

  def draw
    img.draw(@x, @y, 1, scale_amount, scale_amount, @color)
  end

  def click(position)
    @color = Rune.random_color
  end

  def within?(position)
    within_x_axis?(position[0]) and within_y_axis?(position[1])
  end

  def self.size
    SIZE
  end

  private

  def within_x_axis?(x)
    x >= @x and x <= end_x
  end

  def within_y_axis?(y)
    y >= @y and y <= end_y
  end

  def end_x
    @x + SIZE
  end

  def end_y
    @y + SIZE
  end

  def img
    RUNE_IMGS[@type]
  end

  def scale_amount
    SIZE.to_f / img.width
  end

  def self.amount_of_rune_types
    RUNE_IMGS.length
  end

  def self.random_rune
    rand(Rune.amount_of_rune_types)
  end

  def self.random_color
    Gosu::Color.new(255, rand(255), rand(255), rand(255))
  end
end
