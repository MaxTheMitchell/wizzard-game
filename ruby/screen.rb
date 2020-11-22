class Screen
  def initialize(elements)
    @elements = elements
  end

  def draw(mouse_position)
    @elements.each { |e| e.draw mouse_position }
  end

  def click(left_click, mouse_position)
    @elements.filter { |e| e.clickable? mouse_position }.each do
      |e| e.click left_click, mouse_position end
  end

  def over_clickable?(mouse_position)
    @elements.any? { |e| e.clickable? mouse_position and not e.instance_of? Player }
  end
end
