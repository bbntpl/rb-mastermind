# frozen_string_literal: true

require_relative 'circle'

# Feedback consists of user feedback circles that helps the user to figure out
# the code through trial and error
class Feedback
  attr_accessor :feedback

  def initialize(*args)
    @feedback = []

    create_feedback(*args)
  end

  def red_peg
    Circle.new('255', '0', '0', 'red')
  end

  def white_peg
    Circle.new('255', '255', '255', 'white')
  end

  def add_red_pegs(hidden_code, guess)
    red_pegs_count = hidden_code.zip(guess).count { |h, g| h == g }
    feedback.prepend(*Array.new(red_pegs_count, red_peg))
  end

  def add_white_pegs(hidden_code, guess)
    hidden_code_counts = Hash.new(0)
    guess_counts = Hash.new(0)
    hidden_code.zip(guess).each do |sc, gc|
      if sc != gc
        hidden_code_counts[sc] += 1
        guess_counts[gc] += 1
      end
    end

    white_pegs_count = guess_counts.sum { |c, i| [i, hidden_code_counts[c]].min }
    feedback.append(*Array.new(white_pegs_count, white_peg))
  end

  def create_feedback(*args)
    add_red_pegs(*args)
    add_white_pegs(*args)
  end
end
