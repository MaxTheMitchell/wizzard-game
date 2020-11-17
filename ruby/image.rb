require "gosu"

class Image
  def initialize path, size, img = nil
    @img = img ||= Gosu::Image.new(path)
    @size = size
  end

  def draw x, y, z, color = 0xff_ffffff
    @img.draw(x, y, z, x_scale, y_scale, color)
  end

  def self.load_tiles path, tile_size, img_size 
    Gosu::Image::load_tiles(path, *tile_size).map do |img|
      new(nil, img_size, img)
    end
  end

  private

  def x_scale
    @size[0].to_f / @img.width
  end

  def y_scale
    @size[1].to_f / @img.height
  end

end
