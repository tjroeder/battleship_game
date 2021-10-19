class Cell
  attr_accessor :coordinate, :ship, :fire_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fire_upon = false
  end
end

