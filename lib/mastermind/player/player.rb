# frozen_string_literal: true

require 'io/console'
require_relative '../code'

# Player class is the participant of the game
class Player
  attr_accessor :score
  attr_reader :name

  def initialize(name)
    @name = name
    @score = 0
  end

  def turn(config, type = 'enter_code')
    loop do
      code_len = config.code_len
      max_digit = config.max_digit

      puts "\nCode length: #{code_len}, Max int: #{max_digit}"

      code = type == 'enter_code' ? enter_code : guess
      return Code.new(code, config)
    rescue ArgumentError
      puts "\n#{name}! It's an invalid code!"
    end
  end

  def guess
    puts "#{name}! Guess: "
    gets.chomp
  end

  def enter_code
    puts "#{name}! Enter the hidden code: "
    $stdin.noecho(&:gets).chomp
  end
end
