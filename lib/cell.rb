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
    # need to write a check to see if cell is fired upon
    @fire_upon = true
    @ship.hit
  end

  def render(show? = false)

    #if !@cell.empty? && @cell.fired_upon? == false

    #  "."
  # initial state - if the cell has not been fired upon puts .
     # if @cell.fire_upon = false && cell.empty = true  puts .
  #if @cell.fire_upon = false && @cell.empty
    # "."
    if @cell.empty? && @cell.fired_upon?
      "M"
    elsif !@cell.empty? && @cell.fired_upon? && !@cell.sunk?
      "H"
    elsif !@cell.empty? && @cell.fired_upon? && @cell.sunk?
      "X"
    elsif !@cell.empty? && show?

  # if the cell has been fired upon and does not contain a ship puts M
     # if @cell.fire_upon = true && cell.empty = true  puts M
   #elsif @cell.fire_upon && @cell.empty
    # "M"

  #if the cell has been fired upon, contains a ship, and is not sunk puts H
    # if @cell.fire_upon = true && cell.empty = false && ship.sunk? = false  puts H
  #elsif @cell.fire_upon && !@cell.empty && !@ship.sunk?
    #puts "H"

  # if the cell has been fired upon, contains a ship, and is sunk puts X
    # if @cell.fire_upon = true && cell.empty = false && ship.sunk? = true  puts X
#  elsif @cell.fire_upon && !@cell.empty && @ship.sunk?
    #puts "X"

  #if the cell contains a ship, even if it has not been fired upon, puts S
      #if @fire_upon = false && cell.empty = false  puts S
  # elsif !@cell.fire_upon && !@cell.empty
    #puts "S"
   end
 end
end
