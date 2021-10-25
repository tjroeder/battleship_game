require './lib/board'
require './lib/game'

RSpec.describe Game do
  let!(:user_board) {Board.new}
  let!(:npc_board) {Board.new}
  let!(:game) {Game.new(user_board, npc_board)}

  describe '#initialize' do
    it 'exists' do
      # game = Game.new(user_board, npc_board)
      expect(game).to be_instance_of(Game)
    end

    it 'creates user and npc boards' do
      expect(game.user_board).to be_instance_of(Board)
      expect(game.npc_board).to be_instance_of(Board)
    end
  end

  describe '#main_menu' do
    it 'prints text to the screen' do
      expect(game.main_menu).to eq("Welcome to BATTLESHIP\nEnter p to play or q to quit")
    end
  end

  describe '#main_menu_check' do
    # it 'quits the game' do
    #   user_input = 'q'

    #   expect(game.main_menu_check(user_input)).to raise_error(SystemError)
    # end

    it 'recognizes wrong input' do
      user_input = '7'

      expected = 'Wrong input, enter p to play or q to quit'
      expect(game.main_menu_check(user_input)).to eq(expected)

      user_input = 'a'
      expect(game.main_menu_check(user_input)).to eq(expected)

      user_input = 'asdfasdoufadshfgk'
      expect(game.main_menu_check(user_input)).to eq(expected)
    end
  end

end
