# frozen_string_literal: true

require_relative '../player/player'
require_relative '../player/computer'

# Module for setting up players based on the selected game mode
module PlayerSetup
  def create_players(mode, codemaker, *pnames)
    case mode
    when 'pvc'
      create_player_and_com(codemaker, *pnames)
    when 'cvc'
      create_two_computers
    else
      create_two_players(codemaker_name, *pnames)
    end
  end

  private

  def create_player_and_com(codemaker_name, pname)
    p = Player.new(pname)
    c = Computer.new('COM')

    # Codemaker goes first and codebreaker is positioned last
    p.name == codemaker_name ? [p, c] : [c, p]
  end

  def create_two_players(codemaker_name, pname, pname2)
    p = Player.new(pname)
    p2 = Player.new(pname2)

    # Codemaker goes first and codebreaker is positioned last
    p.name == codemaker_name ? [p, p2] : [p2, p]
  end

  def create_two_computers
    # Codemaker goes first and codebreaker is positioned last
    [Computer.new('COM'), Computer.new('COM2')]
  end
end
