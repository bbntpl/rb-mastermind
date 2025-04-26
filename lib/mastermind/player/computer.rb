# frozen_string_literal: true

# A sub class of Player that allows to have a randomize guess
class Computer < Player
  def initialize(name: 'COM')
    super(name)
  end

  def generate_guess(game)
    rand(1111..game.code_len * 1111).to_s
  end
end
