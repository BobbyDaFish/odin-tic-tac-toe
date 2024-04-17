# frozen_string_literal: true

require 'pry-byebug' # temporary for debugging

# This is the player class, it will hold the symbol, a boolean for whether it is their turn
# and their most recent play
class Player
  attr_accessor :turn, :choice
  attr_reader :player_icon

  def initialize(player_icon, turn, choice)
    @player_icon = player_icon
    @turn = turn
    @choice = choice
  end

  def turn?
    @turn
  end

  def player_turn(board)
    puts board[:row1].join(', '), board[:row2].join(', '), board[:row3].join(', ')
    puts "Player #{player_icon} where do you want to play? Choose a number from the board."
    @choice = valid_play?(gets.chop.to_i, board) # get the player's choice, and check to make sure it's a valid number, and a valid play.
    update_board(@choice, board) # update game board to reflect their play
    board
  end

  def valid_play?(choice, board) # validate possible move
    valid_play = false
    until valid_play == true
      if choice == choice.to_i
        if board.any? { |_k, a| a.include?(choice) }
          valid_play = true
          choice
        else
          puts 'Invalid choice, enter a number from the board.'
          choice = gets.chop.to_i
        end
      else
        puts 'Invalid choice, enter a number from the board.'
        choice = gets.chop.to_i
      end
    end
  end

  def winner?(board)
    win_cond = [@player_icon, @player_icon, @player_icon]
    if board[:row1] == win_cond ||
       board[:row2] == win_cond ||
       board[:row3] == win_cond ||
       win_cond == [board[:row1][0], board[:row2][1], board[:row3][2]] ||
       win_cond == [board[:row1][2], board[:row2][1], board[:row3][0]]
      puts board[:row1].join(', '), board[:row2].join(', '), board[:row3].join(', ')
      puts "Player #{player_icon} wins!"
      game_playing = false
    else
      puts "Player #{player_icon}\'s turn is over."
    end
  end

  def update_board(choice, board)
    binding.pry
    if [1, 2, 3].include?(choice)
      i = board[:row1].index(choice)
      board[:row1][i] = @player_symbol
    elsif [4, 5, 6].include?(choice)
      i = board[:row2].index(choice)
      board[:row2][i] = @player_symbol
    else
      i = board[:row3].index(choice)
      board[:row3][i] = @player_symbol
    end
    board
  end
end

def new_board
  {
    row1: [1, 2, 3],
    row2: [5, 4, 6],
    row3: [7, 8, 9]
  }
end

x_player = Player.new('X', true, 0)
o_player = Player.new('O', false, 0)

game_board = new_board
game_playing = true

puts 'Time to play! Determine who goes first by rock, paper, scissors!'
puts game_board[:row1].join(', '), game_board[:row2].join(', '), game_board[:row3].join(', ')
while game_playing
  if x_player.turn
    game_board = x_player.player_turn(game_board)
    x_player.winner?(game_board) # check win conditions
    x_player.turn = false
    o_player.turn = true
  elsif o_player.turn
    game_board = o_player.player_turn(game_board)
    o_player.is_winner?(game_board) # check win conditions
    x_player.turn = true
    o_player.turn = false
  end
  if is_draw?(game_board) # check if game is draw
    puts game_board[:row1].join(', '), game_board[:row2].join(', '), game_board[:row3].join(', ')
    puts 'The game is a draw!'
    game_playing = false
  else
    puts 'Next turn!'
  end
end
