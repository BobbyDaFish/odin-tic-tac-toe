# frozen_string_literal: true

require 'pry-byebug' # temporary for debugging

# This is the player class, it will hold the symbol, a boolean for whether it is their turn
# and their most recent play
class Player
  def initialize(player_symbol, turn, play)
    @player_symbol = player_symbol
    @turn = turn
    @play = play
  end

end
x_player = Player.new("X", true, 0)
o_player = Player.new("O", false, 0)
