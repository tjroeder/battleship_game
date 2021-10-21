class Cell
  attr_accessor :coordinate, :ship, :fire_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fire_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fire_upon
  end

  def fire_upon
    if !empty?
      @ship.hit
    end
    @fire_upon = true
  end

  def render(show = false)

    if empty? && fired_upon?
      "M"
    elsif fired_upon? && !@ship.sunk?
      "H"
    elsif fired_upon? && @ship.sunk?
      "X"
    elsif !fired_upon? && show
      "S"
    else
      "."
    end
   end
 end
