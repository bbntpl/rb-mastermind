# frozen_string_literal: true

# Player
class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @score = 0
  end

  def guess(input)
    Integer(input)
  rescue ArgumentError => e
    puts "Invalid input: #{e.message}"
  end
end
