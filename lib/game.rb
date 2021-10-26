require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

class Game
  attr_accessor :user_board, :user_ships, :npc, :npc_ships, :num_to_name
  
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

  def main_menu
    "Welcome to BATTLESHIP\nEnter p to play or q to quit"
  end

  def main_menu_check(input)
    if input == 'q'
      exit!
    elsif input != 'p'
      "Wrong input, enter p to play or q to quit"
    else
      return true
    end
  end

  def user_input
    input = gets.chomp
  end

  def create_objects
    @user_board = Board.new
    @user_board.cells
    @user_board.selected_rows(4)
    user_cruiser = Ship.new('Cruiser', 3)
    user_submarine = Ship.new('Submarine', 2)
    @user_ships = []
    @user_ships << user_cruiser
    @user_ships << user_submarine
  
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

  def start_game
    "I have laid out my ships on the grid.\n" +
    "You now need to lay out your #{@num_to_name[@user_ships.length]} ships.\n" +
    "The #{@user_ships.first.name} is #{@num_to_name[@user_ships.first.length]} units long and the #{@user_ships.last.name} is #{@num_to_name[@user_ships.last.length]} units long.\n" +
    "#{@user_board.render}"
  end

  def user_placement_selection(ship)
    "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n> "
  end

  def convert_user_coord(input)
    input.split
  end

  def place_user_ship(ship, coordinates)
    if !coordinates.all? { |coord| @user_board.valid_coordinate?(coord) }
      return false
    elsif !@user_board.valid_placement?(ship, coordinates)
      return false
    else
      @user_board.place(ship, coordinates)
      return true
    end
  end

  def invalid_coord
    "Those are invalid coordinates.\nPlease try again:\n> "
  end

  def show_user_ships_setup
    "#{@user_board.render(true)}"
  end

  def setup_board
    create_objects
    puts start_game
    @user_ships.each |ship| do
      puts user_placement_selection(ship)
      user_place_location = convert_user_coord(user_input)

      until place_user_ship(ship, user_place_location)
        puts invalid_coord
        user_place_location = convert_user_coord(user_input)
      end
      puts show_user_ships_setup
    end
  end

  def turn
    puts display
    user_shot_location = user_shot_turn
    npc_shot_location = npc_shot_turn
    puts results(user_shot_location, npc_shot_location)
  end

  def display
    "=============COMPUTER BOARD=============\n" +
    "#{@npc.board.render}\n" +
    "==============PLAYER BOARD==============\n" +
    "#{@user_board.render(true)}\n"
  end

  def user_shot_selection_text
    "Enter the coordinate for your shot:\n> "
  end
  
  def invalid_user_shot
    "Please enter a valid coordinate:\n> "
  end

  def user_shot_turn
    puts user_shot_selection_text
    user_shot_coord = user_input
    when !@user_board.board_hash.include?(user_shot_coord) || @user_board.board_hash[user_shot_coord].shot_status
      puts invalid_user_shot
      user_shot_coord = user_input
    end
    user_shot_coord
  end

  def npc_shot_turn
    @npc.computer_shoot(@user_board)
  end

  def results(user_shot, npc_shot)
    user_shot_word = @render_to_name[@user_board.board_hash[user_shot].render]
    npc_shot_word = @render_to_name[@npc.board.board_hash[npc_shot].render]

    "Your shot on #{user_shot}, #{user_shot_word}.\n" +
    "My shot on #{npc_shot}, #{npc_shot_word}."
  end
end
