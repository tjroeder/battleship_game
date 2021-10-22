require './lib/cell'

class Board
  attr_accessor :cells, :board_hash

  def initialize

  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.length &&
    coordinates.each_cons(2).all? do |x,y|
      if x[0] == y[0]
        x[1].ord + 1 == y[1].ord
      elsif x[0].ord + 1 == y[0].ord
        x[1] == y[1]
      else
        false
      end
    end &&
    coordinates.all? do |sel_coord|
      @board_hash[sel_coord].empty?
    end
  end

  def place(ship, coordinates)
    coordinates.each do |sel_coord|
      @board_hash[sel_coord].place_ship(ship)
    end
  end
end
