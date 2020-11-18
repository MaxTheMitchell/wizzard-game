require_relative "./board"
require_relative "./rune"
require_relative "./color"


class PuzzleScreen
  def initialize(size)
    @elements = 
  end

  def draw(mouse_position)
    @elements.each { |e| e.draw mouse_position }
  end

  def click(left_click, mouse_position)
    @elements.filter { |b| b.clickable? mouse_position }.each do |e|
      e.click left_click, mouse_position
    end
  end
end
