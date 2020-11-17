require_relative "./image"
require_relative "./button"
require_relative "./color"
require_relative "./puzzleScreen"
require_relative "./characterSheet"

class TitleScreen
  BACKGROUND_PATH = "assets/title_screen.jpg"

  def initialize(size, window)
    @size = size
    @background = Image.new(BACKGROUND_PATH, size)
    @window = window
    @buttons = [
      Button.new(
        [size[0] * 0.7, size[1] * 0.3],
        [size[0] * 0.2, size[1] * 0.1],
        "Start New Game",
        Color.rgba(255, 0, 255),
        method(:start_new_game),
        hover_color: Color.rgba(255, 100, 255),
      ),
    ]
    @wiz = CharacterSheet.new({
      path:"assets/wiz_character_sheet.png",
      tile_size: [600,1050],
      img_size: [200,400]
    })
  end

  def draw(mouse_position)
    @background.draw(0, 0, 0)
    @buttons.each { |b| b.draw(mouse_position) }
    @wiz.draw 500,400,0
    @wiz.draw 700,400,1
    @wiz.draw 900,400,2
    @wiz.draw 1100,400,3
  end

  def click(left_mouse, mouse_position)
    @buttons.filter {|b| b.clickable? mouse_position}.each do  |b| 
      b.click left_mouse
    end
  end

  def start_new_game
    @window.current_screen = PuzzleScreen.new @size
  end
end
