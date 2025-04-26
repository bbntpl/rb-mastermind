# frozen_string_literal: true

# Code is a Mastermind class to store patterns of code
# either the hidden code or the codebreaker guess
class Code
  include Validation
  attr_reader :str, :len, :to_arr

  def initialize(str, len, max_int)
    validate_length!(len)
    validate_string!(str)

    @str = str
    @len = len
    @max_int = max_int
    @to_arr = str.chars(str)
  end

  def generate_code
    'TODO'
  end
end
