# frozen_string_literal: true

require_relative '../utility/error_handlers'
require_relative 'player_setup'
require_relative '../game_config'

# PromptsSetup is a module that contains instance methods for asking the user
# for game configuration purposes
module PromptsSetup
  include ErrorHandlers
  include PlayerSetup

  MODES = { 1 => :pvp, 2 => :pvc, 3 => :cvc }.freeze
  PROMPTS = {
    mode: <<~MODE_PROMPT,
      Select a mode:
      1. Player vs Player
      2. Player vs Computer
      3. Computer vs Computer
      Or enter \"d\" to use default settings for quick game setup
    MODE_PROMPT
    player_name: 'Enter a name for',
    role: 'Which one should be the code maker',
    code_len: <<~CODE_LEN_PROMPT,
      Enter the code length (4 or 5 digits):
      Example:
        4 -> 4153 (has 4 digits)
        5 -> 56113 (has 5 digits)
    CODE_LEN_PROMPT
    max_digit: 'Pick between 6-8 as max digit',
    name_requirement: 'Name must have 2-12 characters'
  }.freeze

  # Contains utility methods to get back to the game or not after the game ends
  module Restart
    def prompt_restart
      loop do
        puts "(r) Restart the Game\n(c) Configure the rules and start the game \n(q) Quit the program"
        o = gets.chomp

        validate_option!(o.downcase, %w[c r q])
        return o
      rescue ArgumentError => e
        puts e
      end
    end
  end

  def prompt_config(game_exists)
    unless game_exists
      gamemode = mode
      return gamemode if gamemode == 'd'

      players = players(gamemode)
    end

    code_len = prompt_int(:code_len, [4, 5])
    max_digit = prompt_int(:max_digit, [6, 8])
    config = GameConfig.new(gamemode, code_len, max_digit)
    game_exists ? config : [config, *players]
  end

  private

  # Get mode as valid user input when prompted
  def mode
    mode_key = prompt_mode
    mode_key == 'd' ? default : MODES[mode_key.to_i]
  end

  # Get players as class instances when input is obtained when prompted
  def players(mode)
    c_name, names = prompt_player_stuff(mode) if mode.to_s.include?('p')
    create_players(mode, c_name, *names)
  end

  # Prompt user to select a mode or select default config
  def prompt_mode
    loop do
      puts value_for!(PROMPTS, :mode)
      input = gets.chomp
      return 'd' if input.downcase == 'd'

      int_between!(input.to_i, [1, MODES.size])
      return input
    rescue ArgumentError => e
      puts e
    end
  end

  def prompt_player_stuff(mode)
    names = prompt_player_names(mode)
    [prompt_player_role(names), names]
  end

  def prompt_player_names(mode)
    names = [nil, nil]
    if mode == :pvp
      names[0] = prompt_player_name('Player 1')
      names[1] = prompt_player_name('Player 2', names.compact)
    elsif mode == :pvc
      names[0] = prompt_player_name('the Player', ['COM'])
    end

    names
  end

  def prompt_player_name(default_name, existing_names = [])
    loop do
      puts "#{PROMPTS[:player_name]} #{default_name}: "
      name = gets.chomp
      name_req = value_for!(PROMPTS, :name_requirement)

      ensure_uniq!(name.downcase, existing_names.map(&:downcase), 'Pick another name!')
      int_between!(name.length, [2, 12], name_req)
      return name
    rescue ArgumentError => e
      puts e
    end
  end

  def prompt_player_role(names)
    names = names.map { |name| name || 'COM' }
    loop do
      puts "#{value_for!(PROMPTS, :role)} #{names.join('/')}?"
      codemaker_name = gets.chomp

      validate_option!(codemaker_name.downcase, names.map(&:downcase))
      return codemaker_name
    rescue ArgumentError => e
      puts e
    end
  end

  def prompt_int(prompt_key, range)
    loop do
      puts value_for!(PROMPTS, prompt_key)
      int = gets.chomp

      int_between!(int.to_i, range)
      return int.to_i
    rescue ArgumentError => e; puts e
    end
  end
end
