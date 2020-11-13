require_relative './rune'

class Board

  def initialize(x=0,y=0,options={})
    @x = x
    @y = y
    @runes = options[:runes] ||= random_runes(*options[:size])
  end

  def draw 
    @runes.each do |row|
      row.each{|rune| rune.draw}
    end
  end

  def update
    puts @runes[0][0].type
  end

  private

  def random_runes(x,y)
    (0..x).map do |row|
      (0..y).map{|col|Rune.new(row*Rune.size+@x,col*Rune.size+@y)}
    end
  end

end