require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/ship'
require './lib/computer'

# Create a new instance of the Game class to play Battleship.
game = Game.new

# Main gameplay loop, will exit if user quits in the the main_menu_check, or exits the terminal.
loop do 
  # Print main menu options.
  puts game.main_menu

  # Check if user would like to play Battleship.
  game.main_menu_check

  # Create the boards for the user and the NPC. Select ship locations and prepare to play.
  game.setup_board

  # Take turns shooting at your opponent till one player is left with ships still on the board, or a tie.
  until game.winner
    game.turn
  end
end