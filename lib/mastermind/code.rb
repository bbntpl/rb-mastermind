# frozen_string_literal: true

# Code is a Mastermind class to store patterns of code
# either the hidden code or the codebreaker guess
class Code
  attr_reader :str, :len, :to_arr

  def initialize(str, len)
    validate_length!(len)
    validate_string!(str)

    @str = str
    @len = len
    @to_arr = str.chars(str)
  end

  def validate_string!(str)
    raise ArgumentError, 'Invalid integer in Mastermind code' unless str =~ /1-#{@len}/
  end

  def validate_length!(length)
    raise ArgumentError, 'Code length must be 4-5' unless length.between?(4, 5)
  end
end
