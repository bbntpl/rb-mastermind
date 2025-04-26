# frozen_string_literal: true

# Game
class Game
  attr_reader :in_session

  def initialize(config, player1, player2)
    @config = config
    @in_session = false
    @guesses = []
    @feedbacks = []
    @code = code
    @p1 = player1 # player1 shouldbe the codemaker
    @p2 = player2 # player2 should be the codebreaker
  end

  def valid_guess(guess)
    guesses.append(Code.new(guess))
  end

  def valid_code
    'TODO'
  end

  def show_panel
    'TODO'
  end

  def check_winner
    'TODO'
  end

  def start
    @in_session = true

    'TODO' while @in_session
  end

  def end_game
    @in_session = false
  end
end
