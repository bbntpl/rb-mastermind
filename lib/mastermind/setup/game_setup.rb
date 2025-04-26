# frozen_string_literal: true

# GameSetup is a class that contains methods for setting up the Mastermind
# program
class GameSetup
  include PlayerSetup

  MODES = {
    1 => 'pvp',
    2 => 'pvc',
    3 => 'cvc'
  }.freeze

  def start
    game = init_config
    loop do
      reconfig(game)

      puts 'The game is ready :)'
      puts game.config
      'TODO: Ask user again to play after the game'
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
    config, p1, p2 = prompt_config
    players[0] = p1
    players[1] = p2

    Game.new(config)
  end

  def reconfig(game)
    game.new_config(prompt_config(true))
  end
end
