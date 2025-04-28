# frozen_string_literal: true

# Code is a Mastermind class to store patterns of code
# either the hidden code or the codebreaker guess
class Code
  attr_reader :code

  def initialize(code)
    @code = code
  end
end
