# frozen_string_literal: true

# Player
class Player
  PLAYER_TYPE = %w[HUMAN COM].freeze

  attr_reader :name, :type

  def initialize(name, type)
    validate_type!(type)

    @name = name
    @type = type
  end

  def random_guess(code_len)
    return unless type == 'COM'

    rand(1111..code_len * 1111).to_s
  end

  private

  def validate_type!(type)
    error_msg = 'Player type is invalid must be player or computer'
    raise ArgumentError, error_msg unless PLAYER_TYPE.include?(type)
  end
end
