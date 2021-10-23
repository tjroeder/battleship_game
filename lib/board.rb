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

  def render(show = false)
    render_string = ''
    @board_hash.each_value do |cell_obj|
      render_string << cell_obj.render(show)
    end

    output = ''
    counter = 0
    render_string.gsub(/.{4}/) do |blanks|
      output << @row_array[counter] + blanks + "\n"
      counter += 1
    end
    
    # 1234 string is a placeholder. Need to update for dynamic board.
    output = "  " +  output.prepend("1234\n").gsub(/./) { |s| s + ' ' }
  end
end
