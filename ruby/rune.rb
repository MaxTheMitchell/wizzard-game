require_relative "./image"
require_relative "./color"
require_relative "./hitbox"

class Rune
  attr_accessor :breed, :color

  SIZE = [50, 50]
  RUNE_IMGS = Image.load_tiles("assets/imgs/symbols.png", [100, 100], SIZE)

  def initialize(position, breed = Rune.random_rune, color = Rune.random_color)
    @x = position[0]
    @y = position[1]
    @breed = breed
    @color = color
    @hitbox = Hitbox.new(position, SIZE)
  end

  def draw(x_offput = 0, y_offput = 0)
    img.draw(@x + x_offput, @y + y_offput, 1, *SIZE, @color)
  end

  def click
  end

  def within?(position)
    @hitbox.within? position
  end

  def self.size
    SIZE[0]
  end

  def x
    @x / width
  end

  def y
    @y / height
  end

  private

  def width
    SIZE[0]
  end

  def height
    SIZE[1]
  end

  def img
    RUNE_IMGS[@breed]
  end

  def self.amount_of_rune_breeds
    3
  end

  def self.random_rune
    rand(Rune.amount_of_rune_breeds)
  end

  def self.random_color
    [Color.red, Color.green, Color.blue].sample
  end
end
