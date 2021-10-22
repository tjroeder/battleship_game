class Cell
  attr_accessor :coordinate, :ship, :shot_status

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @shot_status = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @shot_status
  end

  def fire_upon
    if !empty?
      @ship.hit
    end
    @shot_status = true
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
