require './lib/board'
require './lib/cell'
require './lib/game'
require './lib/ship'
require './lib/computer'

game = Game.new

loop do 
  puts game.main_menu
  game.main_menu_check
  game.setup_board
  until game.winner
    game.turn
  end
end