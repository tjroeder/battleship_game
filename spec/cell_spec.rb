require 'rspec'
require './lib/cell'
require './lib/ship'

RSpec.describe Cell do
  let!(:cell)    { Cell.new('B4') }
  let!(:cruiser) { Ship.new('Cruiser', 3) }

  describe '#initialize' do
    # Test for existence of the cell class.
    it 'exists' do
      expect(cell).to be_instance_of(Cell)
    end

    # Test that a cell has corresponding coordinates.
    it 'has coordinates' do
      expect(cell.coordinate).to eq('B4')
    end

    # Test that a cell does not initially have a ship on it (ships must be placed).
    it 'initially has no ship' do
      expect(cell.ship).to eq(nil)
    end
  end

  # Cells are initially empty (no ships).
  describe '#empty?' do
    it 'initially is empty' do
      expect(cell.empty?).to eq(true)
    end

    # Test that cells can have a ship.
    it 'can have a ship' do
      cell.place_ship(cruiser)
      expect(cell.empty?).to eq(false)
    end
  end

  describe '#place_ship' do
    # Test that ships can be placed on a cell.
    it 'can accept a ship' do
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
    end
  end

  describe '#fire_upon and #fired_upon?' do
    # Test that cells are initially not fired on.
    it 'initially not fire_upon' do
      expect(cell.fired_upon?).to eq(false)
    end

    # Test that cells can be fired on, and if they are hit, they lose health.
    it 'change status once fire_upon' do
      cell.place_ship(cruiser)
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end
  end

  describe '#render' do
    # Test that cell status starts as a ".".
    it 'initially has not been fire_upon' do
      expect(cell.render).to eq(".")
    end

    # Test that cell status updates to "M" if it's fired upon and there's no ship.
    it 'change status to a miss once fire_upon and there is no ship' do
      cell.fire_upon
      expect(cell.empty?).to eq(true)
      expect(cell.render).to eq("M")
    end

    # Test that cell status updates to "H" if it's fired upon and there is a ship.
    it 'change status to a hit once fire_upon and there is a ship' do
      cell.place_ship(cruiser)
      cell.fire_upon
      expect(cell.empty?).to eq(false)
      expect(cruiser.sunk?).to eq(false)
      expect(cell.render).to eq("H")
    end

    # Test that cell status updates to "X" once the ship is sunk.
    it 'change status if the ship is sunk' do
      cell.place_ship(cruiser)
      cell.fire_upon
      cruiser.hit
      cruiser.hit
      expect(cell.empty?).to eq(false)
      expect(cruiser.sunk?).to eq(true)
      expect(cell.render).to eq("X")
    end

    # Test that cells initial state is ".".
    it 'status stays the same when render(false) is given' do
      expect(cell.render(false)).to eq(".")
      cell.place_ship(cruiser)
      expect(cell.render(false)).to eq(".")
    end

    # Test that the user's board shows a cell as "S" wherever their ships are.
    it 'change status to S if there is a ship in the cell even if it has not been fire_upon' do
      expect(cell.render(true)).to eq(".")

      cell.place_ship(cruiser)

      expect(cell.empty?).to eq(false)
      expect(cell.render(true)).to eq("S")
    end
  end
end
