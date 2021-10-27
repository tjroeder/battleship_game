require './lib/cell'

class Board
  attr_accessor :board_hash, :row_array

  def initialize
    @board_hash = {}
    @row_array = []
  end

  # Generates range array using letters, from a given number of rows.
  def selected_rows(rows_num)
    @row_array = ('A'.."#{(rows_num + 64).chr}").to_a
  end

  # I don't think I need this while using the times loop in #cells.
  # def selected_col(col_num)
  #   ('1'.."#{col_num}").to_a
  # end

  # Creates the board hash, from Cell objects.
  def cells
    combined = []
    col = 4
    row = ('A'..'D').to_a
    # Generate the boards hash Keys depending on the selected sizes.
    row.each do |r|
      col.times do |i|
        combined << r + (i + 1).to_s
      end
    end

    # Create the Board hash, using the Keys created above, and new Cell objects as values.
    @board_hash = combined.each_with_object({}) do |item, hash|
      hash[item] = Cell.new(item)
    end
  end

  # Check that the coordinate is actually on the player space.
  def valid_coordinate?(coordinate)
    @board_hash.include?(coordinate)
  end

  # Check that the coordinates match ship size, are vertical or horizontal and they are not overlapping with previously placed ships.
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
  
  # Place the ship into the coordinate Cell objects.
  def place(ship, coordinates)
    coordinates.each do |sel_coord|
      @board_hash[sel_coord].place_ship(ship)
    end
  end

  # Convert the Cell object render icon to a string that can be printed as a full board of icons.
  def render(show = false)
    # Create a string of all elements on the board.
    render_string = ''
    @board_hash.each_value do |cell_obj|
      render_string << cell_obj.render(show)
    end

    # Take the elements and segregate them by thier column length. Then add letters to the beginning of the new row, and a newline return to the end.
    output = ''
    counter = 0
    render_string.gsub(/.{4}/) do |blanks|
      output << (@row_array[counter] + blanks + "\n")
      counter += 1
    end
    
    # 1234 string is a placeholder. Need to update for dynamic board.
    # Add padding to the beginning of the string, add column numbers, and add spaces between all characters. Return final string ready for printing.
    output = "  " + output.prepend("1234\n").gsub(/./) { |s| s + ' ' }
  end
end