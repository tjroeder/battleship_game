require 'rspec'
require './lib/cell'
require './lib/ship'
require './lib/board'

RSpec.describe Board do
  let!(:board) { Board.new }
  let!(:cruiser) { Ship.new('Cruiser', 3) }
  let!(:submarine) { Ship.new('Submarine', 2) }

  describe '#initialize' do
    it 'exists' do
      expect(board).to be_instance_of(Board)
    end

    # it 'initally contains an empty hash' do
    #   expect(board.cells).to eq({})
    # end
  end

  describe '#valid_placement?' do
    it 'can check if the coordinates match ship length' do
      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq(false)
    end

    it 'can check if the coordinates are not consecutive' do
      expect(board.valid_placement?(cruiser, ['A1', 'A2', 'A4'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A1', 'C1'])).to eq(false)
      expect(board.valid_placement?(cruiser, ['A3', 'A2', 'A1'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C1', 'B1'])).to eq(false)
    end

    it 'can verify that coordinates are not diagonal' do
      expect(board.valid_placement?(cruiser, ['A1', 'B2', 'C3'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C2', 'D3'])).to eq(false)
    end

    it 'can check valid placements' do
      expect(board.valid_placement?(submarine, ['A1', 'A2'])).to eq(true)
      expect(board.valid_placement?(cruiser, ['B1', 'C1', 'D1'])).to eq(true)
    end

    it 'can check for overlapping ships' do
      board.place(cruiser, ['A1', 'A2', 'A3'])
      expect(board.valid_placement?(submarine, ['A1', 'B1'])).to eq(false)
    end
  end

  describe '#place' do
    it 'can place a ship in board cells' do
      board.place(cruiser, ['A1', 'A2', 'A3'])
      cell_1 = board.board_hash['A1']
      cell_2 = board.board_hash['A2']
      cell_3 = board.board_hash['A3']
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_3.ship == cell_2.ship).to eq(true)
    end
  end
end
