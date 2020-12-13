require_relative "./image"
require_relative "./color"
require_relative "./hitbox"

class Rune
  attr_accessor :breed, :color
  attr_reader :size

  RUNE_IMGS = [
    Image.load_tiles("assets/imgs/cube_sheet.png", [1000, 1000]),
  ]
  ANINMATION_INTERVAL = 5

  def initialize(options = {})
    @position = options[:position]
    @breed = options[:breed] ||= Rune.random_breed
    @color = options[:color] ||= Rune.random_color
    @size = options[:size] ||= [50, 50]
    @hitbox = options[:hitbox] ||= Hitbox.new(position, @size)
    @animation_frame = 0
  end

  def draw
    img.draw(x, y, 2, *@size, @color)
  end

  def click
  end

  def within?(position)
    @hitbox.within? position
  end

  def x
    position[0]
  end

  def y
    position[1]
  end

  def width
    @size[0]
  end

  def height
    @size[1]
  end

  def self.amount_of_rune_breeds
    RUNE_IMGS.length
  end

  private

  def position
    @position
  end

  def img
    RUNE_IMGS[@breed][animation_frame]
  end

  def animation_frame
    @animation_frame += 1
    @animation_frame = 0 if RUNE_IMGS[0].length * ANINMATION_INTERVAL <= @animation_frame
    @animation_frame / ANINMATION_INTERVAL
  end

  def self.random_breed
    rand(amount_of_rune_breeds)
  end

  def self.random_color
    [Color.red, Color.green, Color.blue].sample
  end
end
