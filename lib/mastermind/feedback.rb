# frozen_string_literal: true

class Feedback
  def initialize(hidden_code, guess)
    @hidden_code = hidden_code
    @guess = guess
  end

  def generate_feedback
    []
  end
end
