class Player
  def initialize(options)
    @character_sheet = options[:character_sheet]
    @width, @height = options[:size] ||= @character_sheet
    @x, @y = options[:position] ||= [0, 0]
    @z = options[:z] ||= 2
    @direction = options[:direction] ||= :s
  end

  def draw(mouse_position)
    @character_sheet.draw @x, @y, @direction
  end

  def clickable?(mouse_position) true end

  def click(left_click, mouse_position)
    @x, @y = [mouse_position[0]-img_center[0],mouse_position[1]-img_center[1]]
  end

  private

  def img_center 
    @character_sheet.title_center
  end
end
