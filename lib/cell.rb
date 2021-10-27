class Cell
  attr_accessor :coordinate, :ship, :shot_status

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @shot_status = false
  end
  #cell is empty if there is no ship
  def empty?
    @ship.nil?
  end
  #this method helps place ships on a cell
  def place_ship(ship)
    @ship = ship
  end
  #this method shows the status of a shot/ wether or not a cell has been shot at
  def fired_upon?
    @shot_status
  end
  #this method contains the actual action of shooting on a cell
  #if the cell has a ship, and is fired upon, the ship is hit
  def fire_upon
    if !empty?
      @ship.hit
    end
    @shot_status = true
  end
  #this render shows the possible outcomes of a shot
  def render(show = false)
    #M is a missed shot
    if empty? && fired_upon?
      "M"
    #H is a hit
    elsif fired_upon? && !@ship.sunk?
      "H"
    #the hits will turn to Xs once the ship has sunk
    elsif fired_upon? && @ship.sunk?
      "X"
      #the S shows the user where their ships are placed
    elsif !fired_upon? && !empty? && show
      "S"
      #the . is the standard initial cell status 
    else
      "."
    end
   end
 end
