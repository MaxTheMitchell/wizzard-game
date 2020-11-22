require_relative "./image"

class Background
  def initialize(size, options)
    @img = options[:img] ||= Image.new({size:size,path:options[:path]})
  end

  def draw(mouse_position)
    @img.draw(0, 0, 0)
  end

  def clickable?(mouse_position) false end
end
