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

  describe '#empty?' do
    it 'initially is empty' do
      expect(@cell.empty?).to eq(true)
    end
  
    it 'can have a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#place_ship' do
    it 'can accept a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  describe '#fire_upon and #fired_upon?' do
    it 'initially not fire_upon' do
      expect(@cell.fired_upon?).to eq(false)
    end
  
    it 'change status once fire_upon' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end
  end
end