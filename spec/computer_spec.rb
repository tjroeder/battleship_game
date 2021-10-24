require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

RSpec.describe Computer do
  let!(:cruiser) { Ship.new('Cruiser', 3)}
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
end