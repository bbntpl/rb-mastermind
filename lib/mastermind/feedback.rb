# frozen_string_literal: true

require_relative 'circle'

# Feedback consists of user feedback circles that helps the user to figure out
# the code through trial and error
class Feedback
  attr_reader :feedback

  def initialize(*args)
    @feedback = generate_feedback(*args)
  end

  def generate_feedback(hidden_code, guess)
    feedback = []
    guess.chars.each_with_index do |guess_n, i|
      if guess_n == hidden_code.chars[i]
        feedback.unshift(Circle.new('255', '0', '0', 'red'))
      elsif hidden_code.chars.include?(guess_n)
        feedback.append(Circle.new('255', '255', '255', 'white'))
      end
    end

    feedback
  end
end
