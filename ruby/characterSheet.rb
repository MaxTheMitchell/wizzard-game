require_relative "./image"

class CharacterSheet

  STEPS = 3
  STEP_INTERVAL = 30
  DIRECTION_VALS = {
    s: 0,
    n: 1,
    w: 2,
    e: 3,
  }

  def initialize(options = {})
    @position = options[:position] ||= [0, 0]
    @z = options[:z] ||= 1
    @imgs = Image.load_tiles(options[:path], options[:tile_size], options[:img_size])
    @step = options[:step] ||= 0
  end

  def draw(x, y, direction)
    current_img(direction).draw(x, y, z)
  end

  def title_center
    current_img(:n).img_center
  end

  private

  def current_img(direction)
    @imgs[DIRECTION_VALS[direction] * STEPS + step]
  end

  def width 
    current_img(:n).width
  end

  def height 
    current_img(:n).height
  end

  def x
    @position[0]
  end

  def y
    @position[1]
  end

  def z
    @z
  end

  def step
    @step += 1
    @step = 0 if @step > (STEPS) * STEP_INTERVAL - 1
    @step / STEP_INTERVAL
  end
end
