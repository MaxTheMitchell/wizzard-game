require "json"
require_relative "./image"
require_relative "./hitbox"
require_relative "./grid"

class Map
  GRID_SIDE_LENGTH = 10

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

  def draw(mouse_position)
    @img.draw(x, y, 0)
    @player.draw(
      mouse_position,
      @player.x + x,
      @player.y + y,
    )
  end

  def clickable?(mouse_position)
    not within_a_wall?(adjust_mouse_position(mouse_position))
  end

  def click(left_click, mouse_position)
    puts create_path(@player.position, mouse_position).to_s
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

  def create_grid
    Grid.new(
      list: (0...window_width / GRID_SIDE_LENGTH).map do |x|
        (0...window_height / GRID_SIDE_LENGTH).map do |y|
          not within_a_wall?([x * GRID_SIDE_LENGTH + self.x, y * GRID_SIDE_LENGTH + self.y])
        end
      end,
    )
  end

  def create_path(starting_pos, ending_pos)
    create_grid.find_fatest_path(snap_to_grid(starting_pos),snap_to_grid(ending_pos))
  end

  def snap_to_grid(position)
    [
      (position[0] / GRID_SIDE_LENGTH).to_i,
      (position[1] / GRID_SIDE_LENGTH).to_i,
    ]
  end

  def within_a_wall?(position)
    @walls.any? { |wall| wall.within?(position) }
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
