require './lib/board'

class Game
  attr_accessor :user_board, :npc_board

  def initialize(user_board, npc_board)
    @user_board = user_board
    @npc_board = npc_board
  end


  def main_menu
    #make sure we come back here once we finish.
    #Whenever a game ends, they should return to this message so they can start a new game, or quit.
    "Welcome to BATTLESHIP\nEnter p to play or q to quit"
  end

  def main_menu_check(input)
    if input == 'q'
      # exit!
    elsif input != 'p'
      "Wrong input, enter p to play or q to quit"
    else
    end
  end

  def user_input
    input = gets.chomp
  end
  
  def board_hash
  end

  def start_game
    require "pry"; binding.pry
    "PLACE SHIPS\n" +
    "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n" +
    "#{board_hash}\n" +
    "Enter the squares for the Cruiser (3 spaces)\n>"
  end

  def check_user_coordinates
    if @player_cruiser.input = valid_placement?
      @player_cruiser.place_ship
    elsif
      "Enter the squares for the Cruiser (3 spaces):\n>"
    end

    if @player_submarine.input = valid_coordinate?
      @player_submarine.place_ship
    elsif
      "Enter the squares for the Submarine (2 spaces):\n>"
    end
    #loop until valid coordinates
    #if coordinates are valid, place cruiser first
    #then place submarine
    #if coordinates are not valid, puts "Those are invalid coordinates please try again"
  end

  def setup_board(input)
    #npc places ships randomized
    #user places ships game.user_board
    #puts npc board game.npc_board
    #puts user board
    #puts board.render
  end

  def turn
    #Displaying the boards
# Player choosing a coordinate to fire on
# Computer choosing a coordinate to fire on
# Reporting the result of the Player’s shot
# Reporting the result of the Computer’s shot
  end

  def display
    #display computer board (without ship placement)
    #display player board (with ship placement)
  end

  def player_shot
    #ask for coordinate to fire on
    #loop until valid coordinate
  end

  def npc_shot
    #computer chooses random valid coordinate that has not been chosen yet
  end

  def results
    #puts results of player shot: "your shot on A4 was a miss"
    #puts results of computer shot: "my shot on C1 was a miss"
    #handle missed shots
    #handle hit shots: shot was a hit
    #handle sunk ships: shot was a hit and you sunk my ship
  end

  def player_shot
    #player enters coordinates
    #if invalid, re enter (loop?)
    #if valid but already fired upon, re enter valid coordinate that has not been fired upon
  end

  def end_game
    #diplay "You won!"
    # or display "I won!"
    #then return to main menu
  end



end
