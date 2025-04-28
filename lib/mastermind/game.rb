# frozen_string_literal: true

require_relative 'player/computer'
require_relative 'player/player'
require_relative 'feedback'

# Game
class Game
  attr_reader :in_session, :config, :codebreaker, :codemaker, :guesses, :feedbacks

  def initialize(config, player1, player2)
    @config = config
    @in_session = false
    @guesses = []
    @feedbacks = []
    @hidden_code = nil
    @codemaker = player1
    @codebreaker = player2
  end

  def new_config(config)
    @config = config
  end

  def start
    @in_session = true

    @hidden_code = create_code(generate_code)
    while @in_session
      guess_code = generate_guess
      add_guess(guess_code)
      add_feedback(@hidden_code.code, guess_code)

      print_panel
      end_game if codemaker_win? || codebreaker_win?
      increment_winner_score
    end
  end

  private

  def create_code(guess)
    Code.new(guess, config.code_len, config.max_digit)
  end

  def add_guess(guess)
    guesses.append(create_code(guess))
  end

  def add_feedback(hidden_code, guess)
    feedbacks.append(Feedback.new(hidden_code, guess))
  end

  def print_panel
    guesses.each_with_index do |guess, idx|
      feedback = feedbacks[idx].feedback
      puts "#{idx + 1}) #{guess.code.chars.join(' ')} #{print_circle(feedback)}"
    end
  end

  def print_circle(feedback)
    feedback.map(&:to_s).join(' ')
  end

  def codebreaker_win?
    guesses.any? { |guess| guess.code == @hidden_code.code }
  end

  def codemaker_win?
    guesses.length == 10 && !codebreaker_win?
  end

  def increment_winner_score
    if codebreaker_win?
      @codebreaker.score += 1
      puts "#{codebreaker.name} has won the game!"
    elsif codemaker_win?
      @codemaker.score += 1
      puts "#{codemaker.name} has won the game!"
    end
  end

  def generate_guess
    if @codemaker.instance_of?(Player)
      @codemaker.turn(config, 'guess')
    elsif @codemaker.instance_of?(Computer)
      @codemaker.generate_code(config.code_len, config.max_digit)
    end
  end

  def generate_code
    if @codemaker.instance_of?(Computer)
      @codemaker.generate_code(config.code_len, config.max_digit)
    elsif @codemaker.instance_of?(Player)
      @codemaker.turn(config, 'enter_code')
    end
  end

  def end_game
    @in_session = false
  end
end
