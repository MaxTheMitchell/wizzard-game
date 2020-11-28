require "gosu"
require_relative "../ruby/image"
require_relative "../ruby/mouse"
require "json"

class Window < Gosu::Window
  SIZE = 1920, 1080
  LEFT_MOUSE_ID = 256
  RIGHT_MOUSE_ID = 258
  ESCAPE = 41
  SELECT_SQ = "tools/select_rect.jpeg"

  def initialize
    super(*SIZE, { update_interval: 10, fullscreen: true })
    self.caption = "game prototype"
    @mouse = Mouse.new
    @image = Image.new({
      path: ARGV[0],
    })
    @x = 0
    @y = 0
    @selections = []
  end

  def click(left_mouse, mouse_position)
    if selected?
      @selections[-1] << mouse_position
    else
      @selections << [mouse_position]
    end
  end

  def draw
    update_pos
    @mouse.draw mouse_position, false
    @image.draw(@x, @y)
    draw_selections
  end

  def finish
    File.new("#{ARGV[0].split("/")[-1].split(".")[0]}_map.json", "w").write(
      map_json_data.to_json
    )
    close!
  end

  def map_json_data
    { img_path: ARGV[0].split("/")[-1],
      walls: @selections.map { |s| selection_to_wall(s) } }
  end

  def selection_to_wall(selection)
    {
      position: [[selection[0][0], selection[1][0]].min.to_i,
                 [selection[0][1], selection[1][1]].min.to_i],
      size: [(selection[0][0] - selection[1][0]).abs.to_i,
             (selection[0][1] - selection[1][1]).abs.to_i],
    }
  end

  def draw_selections
    @selections.each do |s|
      if s.length == 1
        draw_selection(s[0], mouse_position_relative)
      else
        draw_selection(*s)
      end
    end
  end

  def draw_selection(pos1, pos2)
    Image.new(path: SELECT_SQ).draw(
      [pos1[0], pos2[0]].min + @x,
      [pos1[1], pos2[1]].min + @y,
      1,
      (pos1[0] - pos2[0]).abs,
      (pos1[1] - pos2[1]).abs,
    )
  end

  def button_down(id)
    case id
    when LEFT_MOUSE_ID
      click(true, mouse_position_relative)
    when RIGHT_MOUSE_ID
      click(false, mouse_position_relative)
    when ESCAPE
      finish
    end
  end

  def update_pos
    if mouse_position[0] <= 0
      @x += 10
    elsif mouse_position[0] >= SIZE[0] - 1
      @x -= 10
    elsif mouse_position[1] <= 0
      @y += 10
    elsif mouse_position[1] >= SIZE[1] - 1
      @y -= 10
    end
  end

  def mouse_position_relative
    [mouse_position[0] - @x, mouse_position[1] - @y]
  end

  def mouse_position
    [mouse_x, mouse_y]
  end

  def selected?
    @selections != [] and @selections[-1].length == 1
  end
end

Window.new.show
