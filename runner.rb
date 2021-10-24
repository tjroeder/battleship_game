require './lib/board'
require './lib/cell'
require './lib/gameplay'
require './lib/ship'

@game = Game.new

#loop here
game.main_menu
input = ''
until input == 'p' || input == 'q'
  input = game.user_input
  puts game.main_menu_check(input)
end

#loop
