# frozen_string_literal: true

require_relative 'circle'

# Feedback consists of user feedback circles that helps the user to figure out
# the code through trial and error
class Feedback
  attr_reader :feedback

  def initialize(hidden_code, guess)
    @feedback = generate_feedback(hidden_code, guess)
  end

  def generate_feedback(hidden_code, guess)
    guess.to_arr.map.with_index.with_object([]) do |(guess_n, i), feedback|
      if guess_n == @hidden_code.to_arr[i]
        feedback.unshift(Circle.new('255', '0', '0', 'red'))
        break
      elsif hidden_code.to_arr.include?(guess_n)
        feedback.append(Circle.new('255', '255', '255', 'white'))
        break
      end
    end
  end
end
