require_relative "./rune"
require_relative "./hitbox"
require_relative "./image"

class Board
  def initialize(options = {})
    @position = options[:position]
    @runes = options[:runes] |= []
    @img = options[:img] ||= nil
  end

  def self.init_from_json(json, position, breeds = Rune.amount_of_rune_breeds, rune_size = [50, 50])
    colors = json["data"]
      .uniq
      .reject { |color| color.last == 0 }
      .map { |color| Color.rgba(*color) }
    puts "amout of colors #{colors.length}"
    runes = json["data"]
      .each_with_index
      .reject { |color, _| color.last == 0 }
      .map do |_, i|
      Rune.new({
        position: [
          position[0] + (i % json["width"]) * rune_size[0],
          position[1] + (i / json["width"]) * rune_size[1],
        ],
        breed: rand(breeds),
        color: colors.sample,
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
    @runes.each(&:draw)
    @img.draw
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

  def spred_color(rune, spred_runes = [])
    spred_runes << rune
    ajacent_runes(rune).filter { |r| rune.breed == r.breed and not spred_runes.include?(r) }.each do |r|
      r.color = rune.color
      spred_color(r, spred_runes)
    end
  end

  def spred_breed(rune, spred_runes = [])
    spred_runes << rune
    ajacent_runes(rune).filter { |r| rune.color == r.color and not spred_runes.include?(r) }.each do |r|
      r.breed = rune.breed
      spred_breed(r, spred_runes)
    end
  end

  def within?(position)
    @runes.any? { |r| r.within?(position) }
  end

  def ajacent_runes(rune)
    [rune_at([rune.x - rune_width / 2, rune.y]), rune_at([rune.x + rune_width / 2, rune.y]),
     rune_at([rune.x, rune.y - rune_hieght / 2]), rune_at([rune.x, rune.y + rune_hieght / 2])].reject(&:nil?)
  end

  def rune_at(position)
    @runes.find { |rune| rune.within?(position) }
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

  def rune_width() rune_size[0] end
  def rune_hieght() rune_size[1] end
  def rune_size() @runes.first.size end
  def x() @position[0] end
  def y() @position[1] end
end
