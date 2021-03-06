require "gosu"

class Text
  attr_accessor :text

  def initialize(options = {})
    @font = Gosu::Font.new(options[:height] ||= 50)
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
      scale_x(options[:width] ||= nil, options[:text] ||= @text),
      scale_y(options[:height] ||= @hieght)
    )
  end

  def text_width(text = @text, font = @font)
    font.text_width(text)
  end

  def adjust_to_width(width, text = self.text)
    self_copy = self.dup
    self_copy.text = break_up_to_fit_width(width, text)
    self_copy
  end

  private

  def break_up_to_fit_width(width, text = self.text)
    return "" if text == ""
    current_line = text.split
    next_line = []
    while text_width(current_line.join(" ")) > width
      next_line << current_line.pop
    end
    "#{current_line.join(" ")}\n#{break_up_to_fit_width(width, next_line.reverse.join(" "))}"
  end

  def scale_x(width = @width, text = @text)
    return 1 if width == nil
    width.to_f / @font.text_width(text)
  end

  def scale_y(hieght = @hieght)
    hieght.to_f / @font.height
  end
end
