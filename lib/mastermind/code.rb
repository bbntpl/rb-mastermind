# frozen_string_literal: true

# Code is a Mastermind class to store patterns of code
# either the hidden code or the codebreaker guess
class Code
  attr_reader :code

  def initialize(code, len, max_digit)
    validate_code!(code, len, max_digit)
    @code = code
  end

  private

  def validate_code!(input, code_len, max_digit)
    if code_len > input.length ||
       !Integer(input) ||
       input.chars.any? { |c| c.to_i > max_digit || c.to_i < 1 }
      raise ArgumentError
    end
  end
end
