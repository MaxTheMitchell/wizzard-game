require "gosu"

class Image
  def initialize(path)
    @img = Gosu::Image.new(path)
  end

  def draw(x, y, z, x_scale = 1, y_scale = 1, color = Gosu::Color.new(255, 255, 255, 255))
    @img.draw(x, y, z, x_scale, y_scale, color)
  end

  def width
    @img.width
  end

  def height
    @img.height
  end

  def self.load_tiles(path, tile_width, tile_height)
    Gosu::Image::load_tiles(path, tile_width, tile_height)
  end
end
