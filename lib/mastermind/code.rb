# frozen_string_literal: true

# Code is a Mastermind class to store patterns of code
# either the hidden code or the codebreaker guess
class Code
  attr_reader :code

  def initialize(code, config)
    validate_code!(code, config)

    @code = code
  end

  private

  def validate_code!(input, config)
    if config.code_len != input.length ||
       !Integer(input) ||
       input.chars.any? { |c| c.to_i > config.max_digit || c.to_i < 1 }
      raise ArgumentError
    end
  end
end
