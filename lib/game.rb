require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class Game
  attr_accessor :user_board, :user_ships, :npc, :npc_ships
  attr_reader :num_to_name, :render_to_name
  
  # Initialize the blank objects and the helper hashes.
  def initialize
    @user_board = ''
    @user_ships = []
    @npc = ''
    @npc_ships = []
    @num_to_name = {
                    10 => 'ten',
                     9 => 'nine',
                     8 => 'eight',
                     7 => 'seven',
                     6 => 'six',
                     5 => 'five',
                     4 => 'four',
                     3 => 'three',
                     2 => 'two',
                     1 => 'one',
                     0 => 'zero'
                   }
    @render_to_name = {
                       'M' => 'was a miss',
                       'H' => 'was a hit',
                       'X' => 'sunk a ship'
                      }
  end

  # Main menu output string.
  def main_menu
    "Welcome to BATTLESHIP\nEnter p to play or q to quit"
  end

  # Check if user would like to play the game, if not exit the game, or ask for new input.
  def main_menu_check
    input = user_input
    until input == 'p'
      if input == 'q'
        exit!
      end
      puts "Wrong input, enter p to play or q to quit"
      input = user_input
    end
  end

  # Collect input from the user.
  def user_input
    input = gets.chomp
  end
  
  # Convert user input from a string to an array for input to other methods.
  def convert_user_coord(input)
    input.split
  end

  # Create all of the battleship objects for user and npc.
  def create_objects
    # Create objects for the user.
    @user_board = Board.new
    @user_board.cells
    @user_board.selected_rows(4)
    user_cruiser = Ship.new('Cruiser', 3)
    user_submarine = Ship.new('Submarine', 2)
    @user_ships = []
    @user_ships << user_cruiser
    @user_ships << user_submarine
  
    # Create objects for the npc, and place the ships.
    npc_cruiser = Ship.new('Cruiser', 3)
    npc_submarine = Ship.new('Submarine', 2)
    @npc_ships = []
    @npc_ships << npc_cruiser
    @npc_ships << npc_submarine
    @npc = Computer.new(@npc_ships)
    @npc.board.cells
    @npc.board.selected_rows(4)
    @npc.computer_place
  end

  # Initial start game string.
  def start_game
    "I have laid out my ships on the grid.\n" +
    "You now need to lay out your #{@num_to_name[@user_ships.length]} ships.\n" +
    "The #{@user_ships.first.name} is #{@num_to_name[@user_ships.first.length]} units long and the #{@user_ships.last.name} is #{@num_to_name[@user_ships.last.length]} units long.\n" +
    "#{@user_board.render}"
  end

  # Request for the user to place the ship.
  def user_placement_selection(ship)
    "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n> "
  end

  # Take the user coordinates and place the ship if it has valid coordinates and placement.
  def place_user_ship(ship, coordinates)
    # Check for valid coordinates and placements. If all are valid, place ship.
    if !coordinates.all? { |coord| @user_board.valid_coordinate?(coord) }
      return false
    elsif !@user_board.valid_placement?(ship, coordinates)
      return false
    else
      @user_board.place(ship, coordinates)
      return true
    end
  end

  # Invalid coordinate string.
  def invalid_coord
    "Those are invalid coordinates.\nPlease try again:\n> "
  end

  # Display the user's board with the ships shown.
  def show_user_ships_setup
    "\n#{@user_board.render(true)}"
  end

  # Complete all of the board setup for the user and the computer.
  def setup_board
    # Create game objects.
    create_objects

    # Print the start game string.
    puts start_game
    # For each ship ask for user input and place them once the given coordinates and placement is valid.
    @user_ships.each do |ship|
      print user_placement_selection(ship)
      user_place_location = convert_user_coord(user_input)

      # Loop until there is a valid input from the user.
      until place_user_ship(ship, user_place_location)
        print invalid_coord
        user_place_location = convert_user_coord(user_input)
      end
      # Show the users ship setup.
      puts show_user_ships_setup
    end
  end

  # Display the game boards, and shoot back and forth. Print results of combat.
  def turn
    puts display
    # User shooting at NPC board.
    user_shot_location = user_shot_turn
    @npc.board.board_hash[user_shot_location].fire_upon
    # NPC shooting at user board.
    npc_shot_location = npc_shot_turn
    @user_board.board_hash[npc_shot_location].fire_upon
    # Print the results of combat.
    print results(user_shot_location, npc_shot_location)
  end

  # Display both battleship boards, in a string.
  def display
    "\n=============COMPUTER BOARD=============\n" +
    "#{@npc.board.render}\n" +
    "==============PLAYER BOARD==============\n" +
    "#{@user_board.render(true)}\n"
  end

  # Ask the user to select a coordinate to shoot at string.
  def user_shot_selection_text
    "Enter the coordinate for your shot:\n> "
  end
  
  # Request the user to select a new coordinate to shoot at string.
  def invalid_user_shot
    "Please enter a valid coordinate:\n> "
  end

  # User shooting method.
  def user_shot_turn
    # Prompt user to shoot.
    print user_shot_selection_text
    # Receive user input for shooting coordinate.
    user_shot_coord = user_input
    # Loop that will exit if the user selects a valid location to shoot at.
    while !@npc.board.board_hash.include?(user_shot_coord) || @npc.board.board_hash[user_shot_coord].shot_status
      print invalid_user_shot
      user_shot_coord = user_input
    end
    user_shot_coord
  end

  # Return random coordinate from NPC to shoot at the user board.
  def npc_shot_turn
    @npc.computer_shoot(@user_board)
  end

  # Display results of the combat shooting.
  def results(user_shot, npc_shot)
    # Convert the render symbol to words for the result output.
    user_shot_word = @render_to_name[@user_board.board_hash[npc_shot].render]
    npc_shot_word = @render_to_name[@npc.board.board_hash[user_shot].render]

    # String for output with the results.
    "\nYour shot on #{user_shot}, #{npc_shot_word}.\n" +
    "My shot on #{npc_shot}, #{user_shot_word}.\n"
  end

  # Select the output string depending on which player won.
  def winner
    if @user_ships.all? { |ship| ship.sunk? }
      print "\nI won!\n\n"
      return true
    elsif @npc_ships.all? { |ship| ship.sunk? }
      print "\nYou won!\n\n"
      return true
    end
  end
end
