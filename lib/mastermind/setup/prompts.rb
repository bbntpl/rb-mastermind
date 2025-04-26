# frozen_string_literal: true

require_relative '../utility/validation'
require_relative 'player_setup'

# PromptsSetup is a module that contains instance methods for asking the user
# for game configuration purposes
module PromptsSetup
  include Validation
  include PlayerSetup

  PROMPTS = {
    mode: <<~MODE_PROMPT,
      Select a mode:
      1. Player vs Computer
      2. Player vs Player
      3. Computer vs Computer
      Or enter \"d\" to use default settings for quick game setup
    MODE_PROMPT
    player_name: 'Type name for ',
    role: 'Which one should be the code maker ',
    code_len: <<~CODE_LEN_PROMPT,
      Enter the code length (4 or 5 digits):
      Example:
        4 -> 4153 (has 4 digits)
        5 -> 56113 (has 5 digits)
    CODE_LEN_PROMPT
    max_int: 'Pick between 6-8 as max integer that code digit num can have',
    name_requirement: 'Name must have 2-12 characters'
  }.freeze

  def prompt_config(game_exists: false)
    unless game_exists
      mode = prompt_mode
      return default if mode == 'd'

      names, c_name = prompt_player_stuff if mode.include?('p')
      players = create_players(mode, c_name, names)
    end

    code_len = prompt_code_len
    max_int = prompt_max_int

    config = GameConfig.new(mode, code_len, max_int)
    game_exists ? config : [config, *players]
  end

  private

  def prompt_mode
    puts GameSetup.prompt_for(:mode)
    input = gets.chomp

    return 'd' if input.downcase == 'd'

    sz = MODES.size
    int_between(sz, [1, sz], value_for(PROMPTS, :mode))
    input
  end

  def prompt_player_stuff(mode)
    names = prompt_player_names(mode)
    [names, prompt_player_role(names)]
  end

  def prompt_player_names(mode)
    names = [nil, nil]
    if mode == 'pvp'
      names[0] = prompt_player_name('Player 1')
      names[1] = prompt_player_name('Player 2')
    elsif mode == 'pvc'
      names[0] = prompt_player_name('the Player')
    end

    names
  end

  def prompt_player_name(default_name)
    puts "#{PROMPTS[:player_name]} #{default_name}: "
    name = gets.chomp
    len = name.length
    range = [2, 12]

    int_between!(len, range, value_for!(PROMPTS, :name_requirement))

    name
  end

  def prompt_player_role(names)
    names = names.map { |name| name || 'Unknown' }
    joined_names = names.join('/')
    q = "#{value_for!(PROMPTS, :role)} #{joined_names}?"

    puts q
    codemaker_name = gets.chomp

    validate_option!(codemaker_name, names, q)
    codemaker_name
  end

  def prompt_code_len
    q = "#{value_for!(code_len)}: "
    puts q

    code_len = gets.chomp

    int_between!(code_len.to_i, [4, 5], q)
    code_len
  end

  def prompt_max_int
    q = "#{value_for!(max_int)}: "
    puts q

    max_int = gets.chomp

    int_between!(max_int.to_i, [6, 8], q)
    max_int
  end
end
