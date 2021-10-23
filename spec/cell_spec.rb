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

  describe '#render' do
    it 'initially has not been fire_upon' do
      expect(@cell.render).to eq(".")
    end

    it 'change status to a miss once fire_upon and there is no ship' do
      @cell.fire_upon
      expect(@cell.empty?).to eq(true)
      expect(@cell.render).to eq("M")
    end

    it 'change status to a hit once fire_upon and there is a ship' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.empty?).to eq(false)
      expect(@cruiser.sunk?).to eq(false)
      expect(@cell.render).to eq("H")
    end

    it 'change status if the ship is sunk' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      @cruiser.hit
      @cruiser.hit
      expect(@cell.empty?).to eq(false)
      expect(@cruiser.sunk?).to eq(true)
      expect(@cell.render).to eq("X")
    end

    it 'status stays the same when render(false) is given' do
      expect(@cell.render(false)).to eq(".")
      @cell.place_ship(@cruiser)
      expect(@cell.render(false)).to eq(".")
    end

    it 'change status to S if there is a ship in the cell even if it has not been fire_upon' do
      expect(@cell.render(true)).to eq(".")
      
      @cell.place_ship(@cruiser)

      expect(@cell.empty?).to eq(false)
      expect(@cell.render(true)).to eq("S")
    end
  end
end
