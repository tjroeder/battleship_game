require './lib/cell'

class Board
  attr_accessor :board_hash, :row_array, :board_rows, :board_cols

  def initialize(board_rows, board_cols)
    @board_hash = {}
    @row_array = []
    @board_rows = board_rows
    @board_cols = board_cols
  end

  # Generates range array using letters, from a given number of rows.
  def selected_rows
    @row_array = ('A'.."#{(@board_rows + 64).chr}").to_a
  end

  # Creates the board hash, from Cell objects.
  def cells
    combined = []
    selected_rows
    # col = 4
    # row = ('A'..'D').to_a
    # Generate the boards hash Keys depending on the selected sizes.
    @row_array.each do |r|
      @board_cols.times do |i|
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
  def valid_placement?(ship, coords)
    size_check(ship, coords) && cons_check(coords) && ship_check(coords)
  end

  # Check that the coordinates match ship size.
  def size_check(ship, coords)
    ship.length == coords.length
  end

  # Check that the coordinates are vertical or horizontal and not diagonal.
  def cons_check(coords)
    coords.each_cons(2).all? do |first, second|
      if first[0] == second[0]
        first[1].ord + 1 == second[1].ord
      elsif first[0].ord + 1 == second[0].ord
        first[1] == second[1]
      else
        false
      end
    end
  end

  # Check that the coordinates are not overlapping with previously placed ships.
  def ship_check(coords)
    coords.all? do |sel_coord|
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
    render_string.gsub(/.{#{@board_cols}}/) do |blanks|
      output << (@row_array[counter] + blanks + "\n")
      counter += 1
    end

    # 1234 string is a placeholder. Need to update for dynamic board.
    # Add padding to the beginning of the string, add column numbers, and add spaces between all characters. Return final string ready for printing.
    output = "  " + output.prepend("1234\n").gsub(/./) { |s| s + ' ' }
  end
end
