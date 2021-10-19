require 'rspec'
require './lib/cell'
require './lib/ship'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new('B4')
    @cruiser = Ship.new('Cruiser', 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_instance_of(Cell)
    end

    it 'has coordinates' do
      expect(@cell.coordinate).to eq('B4')
    end

    it 'initially has no ship' do
      expect(@cell.ship).to eq(nil)
    end
  end
end