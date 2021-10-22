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
    
    it 'initally contains an empty hash' do
      expect(board.cells).to eq({})
    end
  end

  describe '#cells' do
    it 'creates hash of cell data' do
      board.cells
      
      expect(board.cells["A1"]).to have_attributes(:coordinate => "A1", :ship => nil, :shot_status => false)
      expect(board.cells["A2"]).to have_attributes(:coordinate => "A2", :ship => nil, :shot_status => false)
      expect(board.cells["A3"]).to have_attributes(:coordinate => "A3", :ship => nil, :shot_status => false)
      expect(board.cells["A4"]).to have_attributes(:coordinate => "A4", :ship => nil, :shot_status => false)
      expect(board.cells["B1"]).to have_attributes(:coordinate => "B1", :ship => nil, :shot_status => false)
      expect(board.cells["B2"]).to have_attributes(:coordinate => "B2", :ship => nil, :shot_status => false)
      expect(board.cells["B3"]).to have_attributes(:coordinate => "B3", :ship => nil, :shot_status => false)
      expect(board.cells["B4"]).to have_attributes(:coordinate => "B4", :ship => nil, :shot_status => false)
      expect(board.cells["C1"]).to have_attributes(:coordinate => "C1", :ship => nil, :shot_status => false)
      expect(board.cells["C2"]).to have_attributes(:coordinate => "C2", :ship => nil, :shot_status => false)
      expect(board.cells["C3"]).to have_attributes(:coordinate => "C3", :ship => nil, :shot_status => false)
      expect(board.cells["C4"]).to have_attributes(:coordinate => "C4", :ship => nil, :shot_status => false)
      expect(board.cells["D1"]).to have_attributes(:coordinate => "D1", :ship => nil, :shot_status => false)
      expect(board.cells["D2"]).to have_attributes(:coordinate => "D2", :ship => nil, :shot_status => false)
      expect(board.cells["D3"]).to have_attributes(:coordinate => "D3", :ship => nil, :shot_status => false)
      expect(board.cells["D4"]).to have_attributes(:coordinate => "D4", :ship => nil, :shot_status => false)
    end
  end
  
  describe '#valid_coordinate?' do
    it 'tells us if the coordinates are on the board' do
      board.cells
      
      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("E1")).to eq(false)
      expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end

  describe '#valid_coordinate?' do
    it 'tells us if the coordinates are on the board' do
      board.cells
      
      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("E1")).to eq(false)
      expect(board.valid_coordinate?("A22")).to eq(false)
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
