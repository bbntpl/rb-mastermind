# frozen_string_literal: true

# GameConfig represents as Game Settings to store the values used
# related to game rules
class GameConfig
  attr_reader :mode, :code_len, :max_digit

  def initialize(mode, code_len, max_digit)
    @mode = mode
    @code_len = code_len
    @max_digit = max_digit
  end
end
