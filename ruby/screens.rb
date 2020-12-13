require_relative "./screen"
require_relative "./button"
require_relative "./board"
require_relative "./color"
require_relative "./player"
require_relative "./background"
require_relative "./characterSheet"
require_relative "./textbox"
require_relative "./dialog"
require_relative "./text"
require_relative "./image"
require_relative "./map"
require "json"

class Screens
  def initialize(size, window)
    @size = size
    @window = window
  end

  def title_screen(size = @size, window = @window)
    Screen.new([
      Background.new(size, path: "assets/imgs/title_screen.jpg"),
      Button.new(
        [size[0] * 0.7, size[1] * 0.3],
        [size[0] * 0.2, size[1] * 0.1],
        "Start New Game",
        Color.rgba(255, 0, 255),
        -> { window.current_screen = graduation },
        hover_color: Color.rgba(255, 100, 255),
      ),
    ])
  end

  def puzzle_screen(size = @size, window = @window)
    Screen.new([
      Background.new(size, path: "assets/imgs/title_screen.jpg"),
      Board.init_from_json(
        JSON.parse(File.new("./assets/mobs/mushroom.json").read),
        [500,10],
        1,
        [40,40]
      )
    ])
  end

  def graduation(size = @size, window = @window)
    father_text_color = Color.rgba(173 / 1.2, 216 / 1.2, 230 / 1.2)
    mother_text_color = Color.rgba(230 / 1.2, 186 / 1.2, 172 / 1.2)
    player_text_color = Color.rgba(40, 30, 50)

    father = Image.new({
      path: "assets/imgs/parent1.png",
      size: [size[0] / 2, size[1]],
      position: [0, 0],
      color: Color.rgba(173, 216, 230),
      static: true,
    })

    mother = Image.new({
      path: "assets/imgs/parent2.png",
      size: [size[0] / 2, size[1]],
      position: [size[0] / 2, 0],
      color: Color.black,
      static: true,
    })

    dialog = Dialog.new({ textboxes: [
      Textbox.new({ text: Text.new(text: "Look at you son, ya made it through magic school in one peice."), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "We're so proud of our little wizzard!"), color: mother_text_color }),
      Textbox.new({ text: Text.new(text: "..."), color: player_text_color }),
      Textbox.new({ text: Text.new(text: "Honey, he's a sorcerer, not a wizzard."), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "Oh yeah sorry, my bad! I forgot."), color: mother_text_color }),
      Textbox.new({ text: Text.new(text: "Sorcary is a fine career. And anyway they make becoming a wizzard luducrusly difficult task."), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "Hell, even ya old man barely passed his wizzarding exams."), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "..."), color: player_text_color }),
      Textbox.new({ text: Text.new(text: "I heard that prof Duftle Dumft was able to set you up with an entry level adventuring job."), color: mother_text_color }),
      Textbox.new({ text: Text.new(text: "And you start next week!"), color: mother_text_color }),
      Textbox.new({ text: Text.new(text: "Oh man, lucky you! I still remember my first days in the adventuring bussiness. Oh the times you'll have."), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "I'm so happy you got a relable carreer like your father. Remember when you used to say you wanted to become... oh what was it? Oh yes a bard!"), color: mother_text_color }),
      Textbox.new({ text: Text.new(text: "..."), color: player_text_color }),
      Textbox.new({ text: Text.new(text: "But now you've put those childish ideas behind you son."), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "..."), color: player_text_color }),
      Textbox.new({ text: Text.new(text: "Right, son?"), color: father_text_color }),
      Textbox.new({ text: Text.new(text: "...right"), color: player_text_color }),
    ],
                          size: [size[0] - size[0] * 0.1, size[1] * 0.2],
                          position: [size[0] * 0.05, size[1] - size[1] * 0.2] })

    Screen.new(
      [father, mother, dialog],
      onclick_funcs: [->(a, b) {
        if dialog.more_textboxes?
          father.color = Color.black
          mother.color = Color.black
          case dialog.current_textbox.color
          when father_text_color
            father.color = Color.rgba(173, 216, 230)
          when mother_text_color
            mother.color = Color.rgba(230, 186, 172)
          end
        else
          window.current_screen = test_screen_movment
        end
      }],
    )
  end

  def test_screen_movment(size = @size, window = @window)
    Screen.new([
      Map.new({
        player: Player.new({
          character_sheet: CharacterSheet.new({
            path: "assets/imgs/character_sheets/wiz_character_sheet.png",
            tile_size: [600, 1050],
            img_size: [100, 200],
          }),
          direction: :ne,
          position: [500, 500],
        }),
        window_size: size,
        file_path: "assets/maps/test_map_map.json",
      }),
    ])
  end

  def maze_screen(size = @size, window = @window)
    Screen.new([
      Map.new({
        player: Player.new({
          character_sheet: CharacterSheet.new({
            path: "assets/imgs/character_sheets/wiz_character_sheet.png",
            tile_size: [600, 1050],
            img_size: [100, 200],
          }),
          direction: :ne,
          position: [0, 0],
        }),
        window_size: size,
        file_path: "assets/maps/maze_map.json",
      }),
    ])
  end
end
