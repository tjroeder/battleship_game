require './lib/board'
require './lib/game'

RSpec.describe Game do
  let!(:game) {Game.new}

  describe '#initialize' do
    it 'exists' do
      expect(game).to be_instance_of(Game)
    end

    it 'creates blank user board and npc instance' do
      expect(game.user_board).to eq('')
      expect(game.npc).to eq('')
    end

    it 'creates empty ship arrays' do
      expect(game.user_ships).to eq([])
      expect(game.npc_ships).to eq([])
    end

    it 'creates num_to_name helper hash' do
      expected = {  
                  10 => 'ten',
                   9 => 'nine',
                   8 => 'eight',
                   7 => 'seven',
                   6 => 'six',
                   5 => 'five',
                   4 => 'four',
                   3 => 'three',
                   2 => 'two',
                   1 => 'one',
                   0 => 'zero'
                 }
      expect(game.num_to_name).to eq(expected)
    end

    it 'creates render_to_name helper hash' do
      expected = {
                  'M' => 'was a miss',
                  'H' => 'was a hit',
                  'X' => 'sunk a ship'
                  }
      expect(game.render_to_name).to eq(expected)
    end
  end

  describe '#main_menu' do
    it 'prints text to the screen' do
      expect(game.main_menu).to eq("Welcome to BATTLESHIP\nEnter p to play or q to quit")
    end
  end

  describe '#start_game' do
    it 'prints required text to the user' do
      game.create_objects
      
      expected =
      "I have laid out my ships on the grid.\n" +
      "You now need to lay out your two ships.\n" +
      "The Cruiser is three units long and the Submarine is two units long.\n" +
      "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
      expect(game.start_game).to eq(expected)
    end
  end

  describe '#user_placement_selection' do
    it 'prints the name of the ship and length' do
      game.create_objects

      expected = "Enter the squares for the Cruiser (3 spaces):\n> "
      expect(game.user_placement_selection(game.user_ships.first)).to eq(expected)
      expected = "Enter the squares for the Submarine (2 spaces):\n> "
      expect(game.user_placement_selection(game.user_ships.last)).to eq(expected)
    end
  end

  describe '#convert_user_coord' do
    it 'it takes in coordinates' do
      expected = ['A1', 'A2', 'A3']
      expect(game.convert_user_coord('A1 A2 A3')).to eq(expected)
    end
  end

  describe '#place_user_ship' do 
    it 'returns false for out of bounds coordinates' do
      game.create_objects
      coord = ['@1', 'A1', 'B1']
      expect(game.place_user_ship(game.user_ships[0], coord)).to eq(false)
    end

    it 'returns false for invalid wrong length coordinates' do
      game.create_objects
      coord = ['A1', 'B1']
      expect(game.place_user_ship(game.user_ships[0], coord)).to eq(false)
    end

    it 'returns false for diagonal ships' do
      game.create_objects
      coord = ['A1', 'B2', 'C3']
      expect(game.place_user_ship(game.user_ships[0], coord)).to eq(false)
    end

    it 'returns false for non consecutive coordinates' do
      game.create_objects
      coord = ['A1', 'A2', 'A4']
      expect(game.place_user_ship(game.user_ships[0], coord)).to eq(false)
      coord = ['A1', 'B1', 'D1']
      expect(game.place_user_ship(game.user_ships[0], coord)).to eq(false)
    end

    it 'places the ship if all coordinates for the ship are valid' do
      game.create_objects
      coord = ['A1', 'A2', 'A3']
      game.place_user_ship(game.user_ships[0], coord)
      expect(game.user_board.board_hash['A1'].empty?).to eq(false)
      expect(game.user_board.board_hash['A2'].empty?).to eq(false)
      expect(game.user_board.board_hash['A3'].empty?).to eq(false)
    end
  end

  describe '#invalid_coord' do
    it 'returns string' do
      expected = "Those are invalid coordinates.\nPlease try again:\n> "
      expect(game.invalid_coord).to eq(expected)
    end
  end

  describe '#show_user_ships_setup' do
    it 'returns render with user ships' do
      game.create_objects
      coord = ['A1', 'A2', 'A3']
      game.place_user_ship(game.user_ships[0], coord)

      expected = "\n  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
      expect(game.show_user_ships_setup).to eq(expected)
    end
  end
end
