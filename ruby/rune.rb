require_relative "./image"

class Rune
  attr_accessor :breed, :color, :x, :y

  RUNE_IMGS = Image.load_tiles("assets/symbols.png", 100, 100)
  SIZE = 50

  def initialize(x = 0, y = 0, breed = Rune.random_rune, color = Rune.random_color)
    @x = x*SIZE
    @y = y*SIZE
    @breed = breed
    @color = color
  end

  def draw(x_offput = 0, y_offput = 0)
    img.draw(@x + x_offput, @y + y_offput, 1, scale_amount, scale_amount, @color)
  end

  def click(position)
  end

  def within?(position)
    within_x_axis?(position[0]) and within_y_axis?(position[1])
  end

  def self.size
    SIZE
  end

  def x
    @x/SIZE
  end

  def y
    @y/SIZE
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
    RUNE_IMGS[@breed]
  end

  def scale_amount
    SIZE.to_f / img.width
  end

  def self.amount_of_rune_breeds
    # RUNE_IMGS.length
    3
  end

  def self.random_rune
    rand(Rune.amount_of_rune_breeds)
  end

  def self.random_color
    [ Gosu::Color::RED.dup,Gosu::Color::BLUE.dup,Gosu::Color::GREEN.dup].sample
    # Gosu::Color.new(255, rand(255), rand(255), rand(255))
  end
end