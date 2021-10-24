require './lib/board'

class Game
  attr_accessor :user_board, :npc_board

  def initialize
    @user_board = Board.new
    @npc_board = Board.new
  end


  def main_menu
    #make sure we come back here once we finish.
    #Whenever a game ends, they should return to this message so they can start a new game, or quit.
    "Welcome to BATTLESHIP\nEnter p to play or q to quit"
  end

  def main_menu_check(input)
    if input == 'q'
      exit!
    elsif input != 'p'
      "Wrong input, enter p to play or q to quit"
    else
    end
  end

  def user_input
    input = gets.chomp
  end

  def start_game
    puts "PLACE SHIPS"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
  end
end
