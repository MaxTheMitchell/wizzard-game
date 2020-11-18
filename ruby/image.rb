require "gosu"

class Image
  attr_reader :width, :height

  def initialize(path, size, options = {})
    @img = options[:img] ||= Gosu::Image.new(path)
    @x, @y = options[:position] ||= [0, 0]
    @z = options[:z] ||= 1
    @width, @height = size
  end

  def draw(x = @x, y = @y, z = @z, color = 0xff_ffffff)
    @img.draw(x, y, z, x_scale, y_scale, color)
  end

  def self.load_tiles(path, tile_size, img_size)
    Gosu::Image::load_tiles(path, *tile_size).map do |img|
      new(nil, img_size, img: img)
    end
  end

  def img_center
    [width / 2, height / 2]
  end

  private

  def x_scale
    @width.to_f / @img.width
  end

  def y_scale
    @height.to_f / @img.height
  end
end
