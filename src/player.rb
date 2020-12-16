require_relative "./hitbox"

class Player
  attr_reader :x, :y
  attr_writer :target_path

  def initialize(options)
    @character_sheet = options[:character_sheet]
    @x, @y = options[:position] ||= [0, 0]
    @z = options[:z] ||= 2
    @direction = options[:direction] ||= :s
    @target_path = options[:target_path] ||= []
    @velocity = options[:velocity] ||= 5
    @hitbox = options[:hitbox] ||= Hitbox.new([@x, @y], [width, height])
  end

  def update
    @direction = change_direction(target_position, x, y)
    @x, @y = move
  end

  def draw(mouse_position, x, y, direction = @direction)
    update if moving?
    @character_sheet.draw x, y, @direction, moving?
    update_target_position if at_target_position?
  end

  def clickable?(mouse_position) false end

  def within?(position)
    @hitbox.within?(position)
  end

  def position
    [x, y]
  end

  private

  def moving?
    target_position != nil
  end

  def at_target_position?
    position == target_position
  end

  def target_position
    @target_path[0]
  end

  def update_target_position
    @target_path.shift
  end

  def img_center
    @character_sheet.tile_center
  end

  def change_direction(target_position, x, y)
    "#{y_direction(target_position[1], y)}#{x_direction(target_position[0], x)}".to_sym
  end

  def x_direction(target_x, current_x = @x)
    if target_x > current_x
      return "e"
    elsif target_x < current_x
      return "w"
    end
    ""
  end

  def y_direction(target_y, current_y = @y)
    if target_y > current_y
      return "n"
    elsif target_y < current_y
      return "s"
    end
    ""
  end

  def move(direction = @direction, target_position = self.target_position)
    [snap_to_target(move_x(direction), target_position[0]), snap_to_target(move_y(direction), target_position[1])]
  end

  def snap_to_target(current_pos, target, velocity = @velocity)
    return target if (current_pos - target).abs < velocity
    current_pos
  end

  def move_x(direction, velocity = @velocity, x = @x)
    return x + velocity if direction[/e/]
    return x - velocity if direction[/w/]
    x
  end

  def move_y(direction, velocity = @velocity, y = @y)
    return y + velocity if direction[/n/]
    return y - velocity if direction[/s/]
    y
  end

  def target_dirrent_from_pos?(target_position = self.target_position, x = @x, y = @y)
    target_position != [x, y]
  end

  def width() @character_sheet.width end
  def height() @character_sheet.height end
end
