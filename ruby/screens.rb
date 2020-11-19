require_relative "./screen"
require_relative "./button"
require_relative "./board"
require_relative "./color"
require_relative "./player"
require_relative "./background"
require_relative "./characterSheet"

BACKGROUND_PATH = "assets/title_screen.jpg"

class Screens
  def initialize(size, window)
    @size = size
    @window = window
  end

  def title_screen(size = @size, window = @window)
    Screen.new([
      Background.new(size, path: BACKGROUND_PATH),
      Button.new(
        [size[0] * 0.7, size[1] * 0.3],
        [size[0] * 0.2, size[1] * 0.1],
        "Start New Game",
        Color.rgba(255, 0, 255),
        -> { window.current_screen = test_screen_movment },
        hover_color: Color.rgba(255, 100, 255),
      ),
    ])
  end

  def puzzle_screen(size = @size, window = @window)
    Screen.new([Board.new([100, 200], size: [20, 10])])
  end

  def test_screen_movment(size = @size, window = @window)
    Screen.new([
      Player.new({
        character_sheet: CharacterSheet.new({
          path: "assets/wiz_character_sheet.png",
          tile_size: [600, 1050],
          img_size: [100, 200],
        }),
        direction: :e,
      }),
    ])
  end
end
