require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

RSpec.describe Computer do
  let!(:cruiser) {Ship.new('Cruiser', 3)}
  let!(:submarine) {Ship.new('Submarine', 2)}
  let!(:ships) {[cruiser, submarine]}
  let!(:npc) {Computer.new(ships)}

  describe '#initialize' do
    it 'exists' do
      expect(npc).to be_instance_of(Computer)
    end

    it 'creates a new board' do
      expect(npc.board).to be_instance_of(Board)
    end

    it 'contains ships' do
      expect(npc.ships).to eq([cruiser, submarine])
    end
  end

  describe '#empty_board_cells' do
    it 'can return the empty board' do
      npc.board.cells

      expected = ['A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4']
      expect(npc.empty_board_cells).to eq(expected)
    end
    
    it 'can return board that has cells missing' do
      npc.board.cells
      npc.board.place(cruiser, ['A2', 'A3', 'A4'])
      
      expected = ['A1', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4']
      expect(npc.empty_board_cells).to eq(expected)
    end
  end

  describe '#random_cell' do
    it 'can return random cell from board' do
      npc.board.cells
      cell_sel = npc.random_cell(npc.board.board_hash.keys)

      expect(npc.board.valid_coordinate?(cell_sel)).to eq(true) 
    end

    it 'can return a single cell if given a single element array' do
      array = ['A1']
      npc.board.cells
      
      expect(npc.random_cell(array)).to eq('A1')
    end
  end

  describe '#adj_cell' do
    it 'can return adjacent cell for given cell' do
      npc.board.cells

      possible_cell = (['A2', 'B1', 'B3', 'C2'])
      new_value = npc.adj_cell(['B2'])
      expect(new_value.length).to eq(2)
      expect(possible_cell.include?(new_value.last)).to eq(true)

      possible_cell = (['@1', 'A0', 'A2', 'B1'])
      new_value = npc.adj_cell(['A1'])
      expect(new_value.length).to eq(2)
      expect(possible_cell.include?(new_value.last)).to eq(true)
    end

    it 'can return the next logical cell' do
      npc.board.cells

      expected = (['A1', 'A2', 'A3'])
      expect(npc.adj_cell(['A1', 'A2']).length).to eq(3)
      expect(npc.adj_cell(['A1', 'A2'])).to eq(expected)
    end
  end

  describe '#valid_cells' do
    it 'can validate possible cells' do
      npc.board.cells

      expected = ['A2', 'B1', 'B3', 'C2']
      expect(npc.valid_cells(['A2', 'B1', 'B3', 'C2'])).to eq(expected)
    end

    it 'can reject non-valid cells' do
      npc.board.cells

      expected = ['A2', 'B1']
      expect(npc.valid_cells(['@1', 'A0', 'A2', 'B1'])).to eq(expected)
    end

    it 'can reject cells that already have ships' do
      npc.board.cells
      npc.board.place(cruiser, ['A1', 'A2', 'A3'])

      expected = ['B1', 'B3', 'C2']
      expect(npc.valid_cells(['A2', 'B1', 'B3', 'C2'])).to eq(expected)
    end
  end

  describe '#computer_place' do
    it 'can place ships on the board that do not overlap' do 
      npc.board.cells
      npc.computer_place

      count = npc.board.board_hash.each_value.count { |cell| cell.empty? }
      expect(count).to eq(11)
    end
  end

  describe '#computer_shoot' do
    it 'can shoot randomly at non-fired upon cells' do
      user_board = Board.new
      user_board.cells
      shot_cell = npc.computer_shoot(user_board)

      expect(user_board.board_hash.keys.include?(shot_cell)).to eq(true)
    end

    it 'can will not shoot at fired upon cells' do
      user_board = Board.new
      user_board.cells
      user_board.board_hash.each_value { |value| value.shot_status = true }
      user_board.board_hash['A1'].shot_status = false
      shot_cell = npc.computer_shoot(user_board)
      
      expect(shot_cell).to eq('A1')
    end
  end
end