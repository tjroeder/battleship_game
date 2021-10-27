require './lib/cell'

class Board
  attr_accessor :board_hash, :row_array

  def initialize
    @board_hash = {}
    @row_array = []
  end

  def selected_rows(rows_num)
    @row_array = ('A'.."#{(rows_num + 64).chr}").to_a
  end

  # I don't think I need this while using the times loop in #cells.
  # def selected_col(col_num)
  #   ('1'.."#{col_num}").to_a
  # end

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

  def valid_placement?(ship, coords)
    size_check(ship, coords) && cons_check(coords) && ship_check(coords)
  end

  def size_check(ship, coords)
    ship.length == coords.length
  end

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

  def ship_check(coords)
    coords.all? do |sel_coord|
      @board_hash[sel_coord].empty?
    end
  end


  def place(ship, coordinates)
    coordinates.each do |sel_coord|
      @board_hash[sel_coord].place_ship(ship)
    end
  end

  def render(show = false)
    render_string = ''
    @board_hash.each_value do |cell_obj|
      render_string << cell_obj.render(show)
    end

    output = ''
    counter = 0
    render_string.gsub(/.{4}/) do |blanks|
      output << (@row_array[counter] + blanks + "\n")
      counter += 1
    end

    # 1234 string is a placeholder. Need to update for dynamic board.
    output = "  " + output.prepend("1234\n").gsub(/./) { |s| s + ' ' }
  end
end
