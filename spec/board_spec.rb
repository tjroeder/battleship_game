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
      expect(board.board_hash).to eq({})
    end
  end

  describe '#cells' do
    it 'creates hash of cell data' do
      board.cells
      
      expect(board.board_hash["A1"]).to have_attributes(:coordinate => "A1", :ship => nil, :shot_status => false)
      expect(board.board_hash["A2"]).to have_attributes(:coordinate => "A2", :ship => nil, :shot_status => false)
      expect(board.board_hash["A3"]).to have_attributes(:coordinate => "A3", :ship => nil, :shot_status => false)
      expect(board.board_hash["A4"]).to have_attributes(:coordinate => "A4", :ship => nil, :shot_status => false)
      expect(board.board_hash["B1"]).to have_attributes(:coordinate => "B1", :ship => nil, :shot_status => false)
      expect(board.board_hash["B2"]).to have_attributes(:coordinate => "B2", :ship => nil, :shot_status => false)
      expect(board.board_hash["B3"]).to have_attributes(:coordinate => "B3", :ship => nil, :shot_status => false)
      expect(board.board_hash["B4"]).to have_attributes(:coordinate => "B4", :ship => nil, :shot_status => false)
      expect(board.board_hash["C1"]).to have_attributes(:coordinate => "C1", :ship => nil, :shot_status => false)
      expect(board.board_hash["C2"]).to have_attributes(:coordinate => "C2", :ship => nil, :shot_status => false)
      expect(board.board_hash["C3"]).to have_attributes(:coordinate => "C3", :ship => nil, :shot_status => false)
      expect(board.board_hash["C4"]).to have_attributes(:coordinate => "C4", :ship => nil, :shot_status => false)
      expect(board.board_hash["D1"]).to have_attributes(:coordinate => "D1", :ship => nil, :shot_status => false)
      expect(board.board_hash["D2"]).to have_attributes(:coordinate => "D2", :ship => nil, :shot_status => false)
      expect(board.board_hash["D3"]).to have_attributes(:coordinate => "D3", :ship => nil, :shot_status => false)
      expect(board.board_hash["D4"]).to have_attributes(:coordinate => "D4", :ship => nil, :shot_status => false)
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
  
  describe '#valid_placement?' do
    it 'can check if the coordinates match ship length' do
      board.cells

      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq(false)
    end

    it 'can check if the coordinates are not consecutive' do
      board.cells

      expect(board.valid_placement?(cruiser, ['A1', 'A2', 'A4'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A1', 'C1'])).to eq(false)
      expect(board.valid_placement?(cruiser, ['A3', 'A2', 'A1'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C1', 'B1'])).to eq(false)
    end
    
    it 'can check valid placements' do
      board.cells

      expect(board.valid_placement?(submarine, ['A1', 'A2'])).to eq(true)
      expect(board.valid_placement?(cruiser, ['B1', 'C1', 'D1'])).to eq(true)
    end

    it 'can verify that coordinates are not diagonal' do
      board.cells

      expect(board.valid_placement?(cruiser, ['A1', 'B2', 'C3'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C2', 'D3'])).to eq(false)
    end
    
    it 'can check for overlapping ships' do
      board.cells
      board.place(cruiser, ['A1', 'A2', 'A3'])
      
      expect(board.valid_placement?(submarine, ['A1', 'B1'])).to eq(false)
    end
  end

  describe '#place' do
    it 'can place a ship in board cells' do
      board.cells
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
