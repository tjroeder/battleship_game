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

end
