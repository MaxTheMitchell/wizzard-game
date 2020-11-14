require_relative "./image"

class TitleScreen
  BACKGROUND_PATH = "assets/title_screen.jpg"

  def initialize(width, hieght)
    @background = Image.new(BACKGROUND_PATH,width,hieght)
  end

  def draw
    @background.draw(0,0,0)
  end

end
