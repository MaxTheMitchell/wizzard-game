require "json"
require_relative "./image"
require_relative "./hitbox"

class Map
  def initialize(options = {})
    if options[:file_path] != nil
      @img, @walls = create_from_file(options[:file_path])
    else
      @img = options[:img]
      @walls = options[:walls]
    end
    @window_size = options[:window_size]
    @player = options[:player]
  end

  def draw(mouse_position = nil)
    @img.draw(x, y, 0)
    @player.draw(
      mouse_position,
      @player.x + x,
      @player.y + y,
    )
  end

  def clickable?(mouse_position = nil) true end

  def click(left_click, mouse_position)
    @player.click(left_click, adjust_mouse_position(mouse_position))
  end

  private

  def create_from_file(file_path)
    file_data = JSON.parse(File.new(file_path).read)
    [
      Image.new(path: file_data["img_path"]),
      file_data["walls"].map { |wall| Hitbox.new(wall["position"], wall["size"]) },
    ]
  end

  def within_player?(position, player)
    player.within?(position)
  end

  def adjust_mouse_position(mouse_position)
    [
      mouse_position[0] - x,
      mouse_position[1] - y,
    ]
  end

  def x(player_x = @player.x)
    position_val(player_x, window_width, width)
  end

  def y(player_y = @player.y)
    position_val(player_y, window_height, hieght)
  end

  def position_val(player_pos, window_size, max_size)
    return_val = (window_size / 2) - player_pos
    return 0 unless return_val < 0
    return window_size - max_size unless return_val > window_size - max_size
    return_val
  end

  def window_center
    [window_width / 2, window_height / 2]
  end

  def window_width() @window_size[0] end
  def window_height() @window_size[1] end
  def width() @img.width end
  def hieght() @img.height end
end
