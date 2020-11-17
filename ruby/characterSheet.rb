require_relative "./image"

class CharacterSheet
  STEPS = 3
  STEP_INTERVAL = 30

  def initialize(options = {})
    @position = options[:position] ||= [0, 0]
    @z = options[:z] ||= 1
    @imgs = Image.load_tiles(options[:path], options[:tile_size], options[:img_size])
    @step = options[:step] ||= 0
  end

  def draw x,y,direction
    @imgs[direction * STEPS + step].draw(x, y, z)
  end

  private

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
    @step = 0 if @step > (STEPS)*STEP_INTERVAL-1
    @step/STEP_INTERVAL
  end
end
