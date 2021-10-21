  class Ship
  attr_accessor :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  # Return true if the ship is sunk and has zero health.
  def sunk?
    @health == 0
  end

  # Hit to remove health from the ship.
  def hit
    @health -= 1
  end
end
