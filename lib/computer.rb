class Computer
  attr_accessor :board, :ships

  def initialize(ships)
    @board = Board.new
    @ships = ships
  end
end