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

  def player_turn
    puts game_board[:row1].flatten
    puts game_board[:row2].flatten
    puts game_board[:row3].flatten
    puts "Player #{player_symbol} where do you want to play? Choose a number from the board."
    @play = valid_play?(gets.chop) # get the player's choice, and check to make sure it's a valid number, and a valid play.
    self.update_board(@play) # update game board to reflect their play
  end

  def valid_play?(play)
    valid_play = false
    until valid_play == true
      if play == play.to_i
        if game_board.isany?(play) == true
          valid_play = true
          play
        else
          puts 'Invalid choice, enter a number from the board.'
          play = gets.chop
        end
      else
        puts 'Invalid choice, enter a number from the board.'
        play = gets.chop
      end
    end
  end
end

x_player = Player.new('X', true, 0)
o_player = Player.new('O', false, 0)

game_board = {}
game_playing = true
