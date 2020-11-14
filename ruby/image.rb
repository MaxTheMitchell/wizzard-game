require "gosu"

class Image
  def initialize(path,width,height)
    @img = Gosu::Image.new(path)
    @width = width
    @height = height
  end

  def draw(x, y, z, color = 0xff_ffffff)
    @img.draw(x, y, z, x_scale, y_scale, color)
  end

  def x_scale
    @width.to_f/@img.width
  end

  def y_scale
    @height.to_f/@img.height
  end

  def self.load_tiles(path, tile_width, tile_height)
    Gosu::Image::load_tiles(path, tile_width, tile_height)
  end
end
