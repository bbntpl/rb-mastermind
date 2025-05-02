# frozen_string_literal: true

require_relative 'player/computer'
require_relative 'player/player'
require_relative 'feedback'

# Game
class Game
  attr_accessor :guesses, :feedbacks
  attr_reader :in_session, :config, :codebreaker, :codemaker

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
    @hidden_code = generate_code
    while @in_session
      round
      print_panel

      if codemaker_win? || codebreaker_win?
        increment_winner_score
        end_game
      end
    end
  end

  private

  def round
    guess_code = generate_guess
    add_guess(guess_code)
    add_feedback(@hidden_code.code, guess_code.code)
  end

  def add_guess(guess)
    guesses.append(guess)
  end

  def create_feedback(hidden_code, guess)
    Feedback.new(hidden_code.chars, guess.chars)
  end

  def add_feedback(hidden_code, guess)
    feedbacks.append(create_feedback(hidden_code, guess))
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
      puts "\n#{codebreaker.name} has won the game!"
    elsif codemaker_win?
      @codemaker.score += 1
      puts "\n#{codemaker.name} has won the game! The secret code was #{@hidden_code.code}"
    end
  end

  def generate_guess
    if @codebreaker.instance_of?(Player)
      @codebreaker.turn(config, 'guess')
    elsif @codebreaker.instance_of?(Computer)
      @codebreaker.generate_code(config)
    end
  end

  def generate_code
    if @codemaker.instance_of?(Computer)
      @codemaker.generate_code(config)
    elsif @codemaker.instance_of?(Player)
      @codemaker.turn(config, 'enter_code')
    end
  end

  def show_score
    p1 = codemaker
    p2 = codebreaker
    puts "#{p1.name}: #{p1.score} - #{p2.score}:#{p2.name}\n"
  end

  def reset_game
    @guesses = []
    @feedbacks = []
  end

  def end_game
    show_score
    reset_game
    @in_session = false
  end
end
