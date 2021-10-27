require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  let!(:cruiser) { Ship.new('Cruiser', 3) }

  describe '#initialize' do
    # Test for existance of the Ship class.
    it 'exists' do
      expect(cruiser).to be_instance_of(Ship)
    end

    # Test for Ship class name attribute.
    it 'has a name' do
      expect(cruiser.name).to eq('Cruiser')
    end

    # Test for Ship class length attribute.
    it 'has a length' do
      expect(cruiser.length).to eq(3)
    end

    # Test for Ship class health attribute.
    it 'has health' do
      expect(cruiser.health).to eq(3)
    end
  end

  describe '#sunk?' do
    # Test if Ship is initially not sunk.
    it 'initially is not sunk' do
      expect(cruiser.sunk?).to eq(false)
    end

    # Test if Ship is hit it will not sink if it still has health.
    it 'can be hit' do
      cruiser.hit
      expect(cruiser.sunk?).to eq(false)
    end

    # Test that if hit enough so health == 0 the Ship is sunk.
    it 'can be sunk' do
      cruiser.hit
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
    end
  end

  describe '#hit' do
    # Before being hit, the Ship is at full health.
    it 'initially has no hits' do
      expect(cruiser.health).to eq(3)
    end

    # Each hit removes health.
    it 'can remove health' do
      cruiser.hit
      expect(cruiser.health).to eq(2)
      cruiser.hit
      expect(cruiser.health).to eq(1)
      cruiser.hit
      expect(cruiser.health).to eq(0)
    end
  end
end
