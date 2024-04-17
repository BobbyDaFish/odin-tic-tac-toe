# frozen_string_literal: true

require 'pry-byebug' # temporary for debugging

class Player
  def initialize(player_symbol, turn, play)
    @player_symbol = player_symbol
    @turn = turn
    @play = play
  end
end
