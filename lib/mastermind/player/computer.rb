# frozen_string_literal: true

require_relative '../code'

# A sub class of Player that allows to have a randomize guess
class Computer < Player
  def initialize(name = 'COM')
    super(name)
  end

  def generate_code(code_len, max_digit)
    code = ''
    code_len.times do
      code += rand(1..max_digit).to_s
    end

    code
  end
end
