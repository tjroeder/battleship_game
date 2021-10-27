class Cell
  attr_accessor :coordinate, :ship, :shot_status

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @shot_status = false
  end

  # Cell is empty if there is no ship.
  def empty?
    @ship.nil?
  end

  # This method helps place ships on a cell.
  def place_ship(ship)
    @ship = ship
  end

  # This method shows the status of a shot/ wether or not a cell has been shot at.
  def fired_upon?
    @shot_status
  end

  # This method contains the actual action of shooting on a cell.
  # If the cell has a ship, and is fired upon, the ship is hit.
  def fire_upon
    if !empty?
      @ship.hit
    end
    @shot_status = true
  end

  # This render shows the possible outcomes of a shot.
  def render(show = false)
    # M is a missed shot.
    if empty? && fired_upon?
      "M"
    # H is a hit.
    elsif fired_upon? && !@ship.sunk?
      "H"
    # Hits will turn to Xs once the ship has sunk.
    elsif fired_upon? && @ship.sunk?
      "X"
    # The S shows the user where their ships are placed.
    elsif !fired_upon? && !empty? && show
      "S"
    # '.' is the standard initial cell status.
    else
      "."
    end
   end
 end
