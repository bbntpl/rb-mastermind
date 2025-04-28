# frozen_string_literal: true

require_relative 'prompts'
require_relative '../game'

# GameSetup is a class that contains methods for setting up the Mastermind
# program
class GameSetup
  include PromptsSetup
  include PromptsSetup::Restart

  def start
    game = init_config
    end_game_decision = 'r'

    loop do
      reconfig(game) if end_game_decision == 'c'

      puts 'The game has started :)'
      game.start

      end_game_decision = prompt_restart
      break if end_game_decision == 'q'
    end
  end

  private

  def default
    config = GameConfig.new('pvp', 4, 6)
    p1 = Player.new('Player1')
    p2 = Player.new('Player2')

    [config, p1, p2]
  end

  def init_config
    config = prompt_config(false)
    Game.new(*config)
  end

  def reconfig(game)
    game.new_config(prompt_config(true))
  end
end
