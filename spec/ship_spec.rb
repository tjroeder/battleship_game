require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new('Cruiser', 3)
  end

  describe '#initialize' do
    # Test for existance of the Ship class.
    it 'exists' do
      expect(@cruiser).to be_instance_of(Ship)
    end

    # Test for Ship class name attribute.
    it 'has a name' do
      expect(@cruiser.name).to eq('Cruiser')
    end

    # Test for Ship class length attribute.
    it 'has a length' do
      expect(@cruiser.length).to eq(3)
    end

    # Test for Ship class health attribute.
    it 'has health' do
      expect(@cruiser.health).to eq(3)
    end
  end
end