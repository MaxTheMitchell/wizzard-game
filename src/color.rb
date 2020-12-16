require "gosu"

module Color
  def self.rgba(r, g, b, a = 255)
    Gosu::Color.rgba(r, g, b, a)
  end

  def self.red() rgba(255, 0, 0) end
  def self.green() rgba(0, 255, 0) end
  def self.blue() rgba(0, 0, 255) end
  def self.black() rgba(0, 0, 0) end
  def self.white() rgba(255, 255, 255) end
end
