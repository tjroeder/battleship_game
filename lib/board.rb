require './lib/cell'

class Board
  attr_accessor :board_hash

  def initialize
    @board_hash = {}
  end

  def cells
    combined = []
    col = 4
    row = ('A'..'D').to_a
    row.each do |r|
      col.times do |i|
        combined << r + (i + 1).to_s
      end
    end

    @board_hash = combined.each_with_object({}) do |item, hash|
      hash[item] = Cell.new(item)
    end
  end

  def valid_coordinate?(coordinate)
    @board_hash.include?(coordinate)
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
  
  def place(ship, coordinates)
    coordinates.each do |sel_coord|
      @board_hash[sel_coord].place_ship(ship)
    end
  end
end
