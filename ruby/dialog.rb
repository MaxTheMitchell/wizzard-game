class Dialog
  def initialize(options = {})
    @textboxes = options[:textboxes]
    @current_textbox_index = options[:current_textbox_index] ||= 0
    @position = options[:position]
    @size = options[:size]
  end

  def clickable?(mouse_position) true end

  def click(left_click, mouse_position)
    @current_textbox_index += 1
  end

  def draw(mouse_pos)
    current_textbox.draw(nil, x, y, width, hieght) if more_textboxes?
  end

  def current_textbox
    @textboxes[@current_textbox_index]
  end

  private

  def x() @position[0] end
  def y() @position[1] end
  def width() @size[0] end
  def hieght() @size[1] end

  def more_textboxes?(current_textbox_index = @current_textbox_index, textboxes = @textboxes)
    current_textbox_index < textboxes.length
  end
end
