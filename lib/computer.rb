class Computer
  attr_accessor :board, :ships

  # Initialize the board and save the ships given to the computer.
  def initialize(ships)
    @board = Board.new
    @ships = ships
  end

  # Return an array with a list of all empty cell Keys.
  def empty_board_cells
    empty_board = []
    board.board_hash.each_pair do |key, value|
      if value.empty?
        empty_board << key
      end
    end
    empty_board
  end

  # Given an array of cell Keys randomly select one that is currently empty.
  def random_cell(array)
    cell_sel = array.sample

    # Keep choosing random cells until one is empty.
    until board.board_hash[cell_sel].empty? do
      cell_sel = array.sample
    end
    cell_sel
  end

  # Given array return with new adjacent coordinate added to the array.
  def adj_cell(array)
    # Set last letter in ordinal.
    last_letter_ord = array[-1][0].ord
    
    # Set last number in ordinal.
    last_num_ord = array[-1][1].ord
    
    # If two or more cells chosen, pick the next logical.
    if array.length >= 2
      # Set bias for letter and number from last two coordinates.
      letter_bias_ord = array[-1][0].ord - array[-2][0].ord 
      num_bias_ord = array[-1][1].ord - array[-2][1].ord

      # Chose new letter and number based on the direction of previous choices.
      new_letter = (last_letter_ord + letter_bias_ord).chr
      new_num = (last_num_ord + num_bias_ord).chr

      # Create output array with the new coordinate.
      output_array = array << (new_letter + new_num)
    else
      # Array of 4 possible ordinal directions for new cells.
      change_array = [[-1, 0], [0, -1], [0, 1], [1, 0]]
      possible_cells = []
      
      # Create an array of all 4 possible coordinates around origin coordinate.
      change_array.each do |letter, num|
        possible_cells << (last_letter_ord + letter).chr + (last_num_ord + num).chr
      end

      # Pick a cell from the possible cells.
      array << possible_cells.sample
      # Create output array with the new coordinate.
      output_array = array.sort
    end
    output_array
  end
  
  # Validate cells in an array, delete any that are valid and not empty.
  def valid_cells(array)
    array.delete_if do |coord| 
      !board.valid_coordinate?(coord) || !board.board_hash[coord].empty?
    end
  end

  # Place the computers ships.
  def computer_place
    # Place each ship using random coordinates.
    count = 1
    ships.each do |ship|
      # Set the initial random coordinate into the ship_array.
      ship_array = [random_cell(empty_board_cells)]
      
      # Until the coordinates are valid, keep finding new coordinates.
      until board.valid_placement?(ship, ship_array) do
        # Find the adjecent cells, then select one to add to ship array.
        ship_array = adj_cell(ship_array)

        # Check if the array has valid coordinates.
        ship_array = valid_cells(ship_array)

        # If the array has no valid coordinates after culling re-choose intial coordinate. If the initial selection is bad, after four iterations reselect seed.
        if ship_array.length == 1 || count == 4
          ship_array = [random_cell(empty_board_cells)]
          count = 0
        end
        count += 1
      end
      board.place(ship, ship_array)
    end
  end

  # Select the coordinate to shoot from the available spots on the user board.
  def computer_shoot(user_board)
    unfired_board = []
    user_board.board_hash.each_pair do |key, value|
      if !value.fired_upon?
        unfired_board << key  
      end 
    end
    unfired_board.sample
  end
end