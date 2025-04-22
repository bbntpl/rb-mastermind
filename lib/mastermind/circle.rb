# frozen_string_literal: true

# Circle represents the Mastermind peg object where each has a distinct color
class Circle
  VALID_SIZES = %w[large small].freeze

  attr_reader :name, :color_code, :size

  def initialize(red, green, blue, name, size = 'small')
    validate_size!(size)

    @r = red
    @g = green
    @b = blue
    @name = name
    @size = size
    @color_code = "\e[38;2;#{red};#{green};#{blue}m"
  end

  def to_s
    circles = {
      large: '▓',
      small: '●'
    }

    "#{@color_code}#{circles[size.to_sym]}\e[0m"
  end

  def validate_size!(size)
    raise ArgumentError, 'Circle must be small or large' unless VALID_SIZES.include?(size)
  end
end
