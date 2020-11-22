require "gosu"

class Text
  def initialize(options = {})
    @font = Gosu::Font.new(options[:height] ||= 100)
    @text = options[:text] ||= ""
    @x = options[:x] ||= 0
    @y = options[:y] ||= 0
    @z = options[:z] ||= 1
    @width = options[:width] ||= @font.text_width(@text)
    @hieght = options[:height] ||= @font.height
  end

  def draw(options = {})
    @font.draw_text(
      options[:text] ||= @text,
      options[:x] ||= @x,
      options[:y] ||= @y,
      options[:z] ||= @z,
      scale_x(options[:width] ||= @width, options[:text] ||= @text),
      scale_y(options[:height] ||= @hieght)
    )
  end

  private

  def scale_x(width = @width, text = @text)
    width.to_f / @font.text_width(text)
  end

  def scale_y(hieght = @hieght)
    hieght.to_f / @font.height
  end
end
