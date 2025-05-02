# frozen_string_literal: true

require_relative '../code'

# A sub class of Player that allows to have a randomize guess
class Computer < Player
  def initialize(name = 'COM')
    super(name)
  end

  def generate_code(config)
    code = ''
    config.code_len.times do
      code += rand(1..config.max_digit).to_s
    end

    Code.new(code, config)
  end
end
