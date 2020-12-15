require_relative "./image"
require_relative "./color"
require_relative "./hitbox"

class Rune
  attr_accessor :breed, :color, :position, :target_position
  attr_reader :size

  RUNE_IMGS = [
    Image.load_tiles("assets/imgs/cube_sheet.png", [1000, 1000]),
    Image.load_tiles("assets/imgs/cone_sheet.png", [800, 800]),
    Image.load_tiles("assets/imgs/donut_sheet.png", [800, 800]),
  ]
  ANINMATION_INTERVAL = 5
  MOVMENT_SPEED = 20

  def initialize(options = {})
    @position = options[:position]
    @breed = options[:breed] ||= Rune.random_breed
    @color = options[:color] ||= Rune.random_color
    @size = options[:size] ||= [50, 50]
    @hitbox = options[:hitbox] ||= Hitbox.new(position, @size)
    @animation_frame = 0
    @target_position = options[:target_position] ||= nil
  end

  def draw
    move unless @target_position.nil?
    img.draw(x, y, 2, *@size, @color)
  end

  def click
  end

  def within?(position)
    @hitbox.within? position
  end

  def within_target_pos?
    Hitbox.new(
      @target_position.map { |p| p - @size.first/2 },
      @size
    ).within?(@position)
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

  def move
    @position[0] -= (@position[0] - target_position[0]).to_f / MOVMENT_SPEED
    @position[1] -= (@position[1] - target_position[1]).to_f / MOVMENT_SPEED
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
