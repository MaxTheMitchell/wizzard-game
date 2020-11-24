require "gosu"

class Image
  attr_accessor :color
  attr_reader :width, :height

  def initialize(options = {})
    @img = options[:img] ||= Gosu::Image.new(options[:path])
    @x, @y = options[:position] ||= [0, 0]
    @z = options[:z] ||= 1
    @width, @height = options[:size] ||= [0, 0]
    @static = options[:static] ||= false
    @color = options[:color] ||= 0xff_ffffff
  end

  def draw(x = @x, y = @y, z = @z, width = @width, height = @height, color = @color)
    if @static
      @img.draw(@x, @y, @z, x_scale(@width), y_scale(@height), @color)
    else
      @img.draw(x, y, z, x_scale(width), y_scale(height), color)
    end
  end

  def self.load_tiles(path, tile_size, img_size)
    Gosu::Image::load_tiles(path, *tile_size).map do |img|
      new({ img: img, size: img_size })
    end
  end

  def clickable?(mouse_position) false end

  def img_center
    [width / 2, height / 2]
  end

  private

  def x_scale(width = @width)
    width.to_f / @img.width
  end

  def y_scale(height = @height)
    height.to_f / @img.height
  end
end
