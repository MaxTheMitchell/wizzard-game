require_relative "./image"

class CharacterSheet
  STEPS = 3
  STEP_INTERVAL = 10
  DIRECTION_VALS = {
    n: 0,
    e: 1,
    w: 2,
    s: 3,
    ne: 4,
    nw: 5,
    sw: 6,
    se: 7,
  }

  def initialize(options = {})
    @position = options[:position] ||= [0, 0]
    @z = options[:z] ||= 1
    @imgs = Image.load_tiles(options[:path], options[:tile_size], options[:img_size])
    @step = options[:step] ||= 0
  end

  def draw(x, y, direction, moving)
    current_img(direction, moving).draw(x, y, z)
  end

  def tile_center
    current_img(:n, false).img_center
  end

  def width
    current_img(:n, false).width
  end

  def height
    current_img(:n, false).height
  end

  private

  def current_img(direction, moving)
    @imgs[
      (DIRECTION_VALS[direction]) * STEPS + (moving ? step : 0)]
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
    @step = 0 if @step > (STEPS * 2 - 2) * STEP_INTERVAL - 1
    return [0, 1, 0, 2][@step / STEP_INTERVAL]
  end
end
