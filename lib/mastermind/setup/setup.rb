# frozen_string_literal: true

require_relative '../utility/game_validation'
require_relative 'player_setup'

# GameSetup is a module that contains methods for setting up the Mastermind
# program
module GameSetup
  include GameValidation
  include PlayerSetup

  MODES = {
    1 => 'pvp',
    2 => 'pvc',
    3 => 'cvc'
  }.freeze

  PROMPTS = {
    mode: <<~MODE_PROMPT,
      Select a mode:
      1. Player vs Computer
      2. Player vs Player
      3. Computer vs Computer
      Or enter \"d\" to use default settings for quick game setup
    MODE_PROMPT
    player_name: ', type your name: ',
    role: 'Who will type the hidden code? Type your name.',
    code_len: 'Enter the code length (4 or 5 digits):\nExample 4 -> 4153, 5 -> 56113\n',
    max_int: 'Pick between 6-8 as max integer that code digit num can have: '
  }.freeze
  REPROMPTS = {
    mode: 'Only choose 1-3 or type "d" for default settings: ',
    role: 'Player name does not exists. Pick between 1) Player1 and 2) Player2 / or type the name: ',
    code_len: 'Only type "4" or "5" for the code length: ',
    max_int: 'Only type "6", "7", or "8" for the max_int: '
  }.freeze

  def start
    'TODO'
  end

  def self.default
    config = GameConfig.new('pvp', 4, 6)
    p1 = Player.new('Player1')
    p2 = Player.new('Player2')

    Game.new(config, p1, p2)
  end

  private

  def prompt_for(key)
    value_for(PROMPTS, key)
  end

  def mode_for(key)
    value_for(MODES, key)
  end

  def error_msg_for(key)
    value_for(ERROR_MSGS, key)
  end

  def configure(code_len, max_int)
    @code_len = code_len
    @max_int = max_int
  end

  def create_players(codemaker, *pnames)
    mode = gamemode
    case mode
    when 'pvc'
      create_player_and_com(codemaker, *pnames)
    when 'cvc'
      create_two_computers
    else
      create_two_players(codemaker_name, *pnames)
    end
  end

  def code_len=(len)
    int_between!(len, [6, 8], ERROR_MSGS['code_len'])

    @code_len = len
  end

  def user_input(game)
    while game.in_session

    end
  end
end
