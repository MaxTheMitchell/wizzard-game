include Math
require_relative "./rune"
require_relative "./hitbox"
require_relative "./image"

class Board

  AMOUNT_OF_TRANSFORMATION_CIRCLES = 50
  FROG_IMG = Image.new({
    path: "assets/imgs/frog.png",
    size: [80,80],
    z: 1
  })

  def initialize(options = {})
    @position = options[:position]
    @runes = options[:runes] |= []
    @img = options[:img] ||= nil
    @static_center = options[:static_center] ||= center
    @display_frog = false
  end

  def self.init_from_json(json, position, breeds = Rune.amount_of_rune_breeds, rune_size = [50, 50])
    colors = json["data"]
      .uniq
      .reject { |color| color.last == 0 }
      .map { |color| Color.rgba(*color) }
    runes = json["data"]
      .each_with_index
      .reject { |color, _| color.last == 0 }
      .map do |color, i|
      Rune.new({
        position: [
          position[0] + (i % json["width"]) * rune_size[0],
          position[1] + (i / json["width"]) * rune_size[1],
        ],
        breed: rand(breeds),
        color: Color.rgba(*color),
        size: rune_size,
      })
    end
    new(
      position: position,
      img: Image.new(
        path: json["img_path"],
        position: position,
        size: self.size(runes),
        z: 0,
        color: Color.rgba(255, 255, 255, 150),
      ),
      runes: runes,
    )
  end

  def draw(mouse_position)
    if won?
      frog_transormation
    end
    FROG_IMG.draw_center(*@transformation_center) if @display_frog
    @runes.each(&:draw)
  end

  def click(left_click, position)
    if left_click
      spred_color rune_at(position)
    else
      spred_breed rune_at(position)
    end
  end

  def clickable?(mouse_position)
    within? mouse_position
  end

  private

  def won?
    @runes.uniq(&:color).length == 1
    # true
  end

  def frog_transormation
    @transformation_center = @transformation_center ||= center
    @transformation_stage = @transformation_stage ||= 0
    if @runes.first.target_position.nil?
      move_to_center
      @transformation_stage = 1
    elsif @runes.all?(&:within_target_pos?) and @transformation_stage == 1
      make_circle
      @transformation_stage = 0
      @display_frog = true
    end
  end

  def move_to_center
    @runes.each { |r| r.target_position = center }
  end

  def make_circle
    center = @runes.first.target_position
    radius = size.min / 2
    deg_amount = AMOUNT_OF_TRANSFORMATION_CIRCLES * 2 * Math::PI / @runes.length
    @runes.each_with_index do |r, i|
      r.target_position = [
        center[0] + radius * Math.cos(i * deg_amount),
        center[1] + radius * Math.sin(i * deg_amount),
      ]
      if (i+1) % ((@runes.length + 1) / AMOUNT_OF_TRANSFORMATION_CIRCLES) == 0
        radius /= 1 + 1.to_f / AMOUNT_OF_TRANSFORMATION_CIRCLES
      end
    end
  end

  def spred_color(rune, spred_runes = [])
    ajacent_runes(rune).filter { |r| rune.breed == r.breed and not spred_runes.include?(r) }.each do |r|
      r.color = rune.color
      spred_color(r, spred_runes << rune)
    end
  end

  def spred_breed(rune, spred_runes = [])
    ajacent_runes(rune).filter { |r| rune.color == r.color and not spred_runes.include?(r) }.each do |r|
      r.breed = rune.breed
      spred_breed(r, spred_runes << rune)
    end
  end

  def within?(position)
    @runes.any? { |r| r.within?(position) }
  end

  def ajacent_runes(rune)
    [rune_at([rune.x - rune_width / 2, rune.y + 1]), rune_at([rune.x + rune_width * 2, rune.y + 1]),
     rune_at([rune.x + 1, rune.y - rune_hieght / 2]), rune_at([rune.x + 1, rune.y + rune_hieght * 2])].reject(&:nil?)
  end

  def rune_at(position)
    @runes.find { |rune| rune.within?(position) }
  end

  def center(runes = @runes)
    [
      Board.width(runes) / 2 + x,
      Board.height(runes) / 2 + y,
    ]
  end

  def self.size(runes = @runes)
    [width(runes), height(runes)]
  end

  def self.width(runes = @runes)
    (runes.map(&:x).uniq.length + 1) * runes.first.width
  end

  def self.height(runes = @runes)
    runes.map(&:y).uniq.length * runes.first.height
  end

  def size() [width, height] end
  def width() Board.width(@runes) end
  def height() Board.height(@runes) end
  def rune_width() rune_size[0] end
  def rune_hieght() rune_size[1] end
  def rune_size() @runes.first.size end
  def x() @position[0] end
  def y() @position[1] end
end
