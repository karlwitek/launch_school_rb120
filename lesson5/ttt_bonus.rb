class Board
  attr_reader :num_of_wins
  MATCH_WINS = 3
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset_number_of_games_won
    reset
  end

  # rubocop:disable Metrics/AbcSize

  def draw
    puts '     |     |'
    puts " #{@squares[1]}   |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts " #{@squares[4]}   |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts " #{@squares[7]}   |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize

  def []=(square, marker)
    @squares[square].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def joinor(available_keys, delimiter = ', ', word = ' or ')
    if available_keys.size == 1
      "#{available_keys[0]}"
    elsif available_keys.size == 2
      "#{available_keys[0]} #{word} #{available_keys[1]}"
    else
    "#{available_keys[0..-2].join(delimiter)} #{word} #{available_keys[-1]}"
    end
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def match_won?
    @num_of_wins.values.max == MATCH_WINS
  end

  def update_games_won(marker)
    if winning_marker == marker
      num_of_wins['human'] += 1
    elsif winning_marker == TTTGame::COMPUTER_MARKER
      num_of_wins['computer'] += 1
    end
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
  
  def reset_number_of_games_won
    @num_of_wins = { 'human' => 0, 'computer' => 0 }
  end

  def middle_square_available?
    return true if @squares[5].marker == Square::INITIAL_MARKER
    false
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      winning_marker = check_for_winning_marker(@squares.values_at(*line))
      return winning_marker if winning_marker
    end
    nil
  end

  # returns the square to defend if human has two in a row (or nil)
  def square_to_defend(marker)
    WINNING_LINES.each do |line|
      index_to_defend = find_blocking_square(@squares.values_at(*line), marker)
      return line[index_to_defend] if index_to_defend
    end
    nil
  end

  # returns the square for computer to win the game (or nil)
  def square_to_win
    WINNING_LINES.each do |line|
      index_to_win = find_offensive_move(@squares.values_at(*line))
      return line[index_to_win] if index_to_win
    end
    nil
  end
  
  private

  def find_blocking_square(squares, marker)
    array_markers = squares.map(&:marker)
    if array_markers.include? Square::INITIAL_MARKER
      number_of_human_markers = array_markers.count(marker)
      if number_of_human_markers == 2
        return array_markers.index(Square::INITIAL_MARKER)
      end
    end
    nil
  end

  def find_offensive_move(squares)
    array_markers = squares.map(&:marker)
    if array_markers.include? Square::INITIAL_MARKER
      number_of_computer_markers = array_markers.count(TTTGame::COMPUTER_MARKER)
      if number_of_computer_markers == 2
        return array_markers.index(Square::INITIAL_MARKER)
      end
    end
    nil 
  end

  def check_for_winning_marker(squares)
    array_markers = squares.map(&:marker)
    if array_markers.include? Square::INITIAL_MARKER
      return nil
    elsif array_markers.uniq.size == 1
      return array_markers[0]
    end
    nil
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker
  attr_reader :name

  def initialize(marker, name)
    @marker = marker
    @name = name
  end
end

class TTTGame
  HUMAN_NAME = "Joe"
  COMPUTER_NAME = "Robot"
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  GAME_SETTING = 'computer'

  private

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER, HUMAN_NAME)
    @computer = Player.new(COMPUTER_MARKER, COMPUTER_NAME)
  end

  def first_player_to_move
    first_player_to_move = nil
    if GAME_SETTING == 'human'
      first_player_to_move = human.marker
    elsif GAME_SETTING == 'computer'
      first_player_to_move = COMPUTER_MARKER
    elsif GAME_SETTING == 'choose'
      puts "Do you want to go first? ( enter 'y' for yes / 'n' for #{computer.name} ):"
      answer = nil
      loop do
        answer = gets.chomp.downcase
        break if ['y', 'n'].include? answer
        puts "Must enter a 'n' or a 'y'."
      end
      first_player_to_move = human.marker if answer == 'y'
      first_player_to_move = COMPUTER_MARKER if answer == 'n'
    end
    first_player_to_move
  end

  def find_first_player_to_move
    @starting_player_for_match = first_player_to_move
    @current_player = @starting_player_for_match
  end

  def choose_marker
    chosen_marker = nil
    loop do
      puts "Enter a character to be your marker, or hit return for 'X' "
      chosen_marker = gets.chomp
      break unless chosen_marker.size > 1
      puts "Your marker must be a length of one character."
    end
    human.marker = chosen_marker == '' ? TTTGame::HUMAN_MARKER : chosen_marker
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ''
    sleep 1
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear
    system 'cls'
  end

  def display_board
    puts "#{human.name}, you're a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ''
    board.draw
    puts ''
  end

  def clear_screen_and_display_board
    clear
    board.draw
  end

  def human_moves
    puts "Choose a square (#{board.joinor(board.unmarked_keys)}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.square_to_win
      board[board.square_to_win] = computer.marker
    elsif board.square_to_defend(human.marker)
      board[board.square_to_defend(human.marker)] = computer.marker
    elsif board.middle_square_available?
      board[5] = computer.marker
    else
      square = board.unmarked_keys.sample
      board[square] = computer.marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = COMPUTER_MARKER
    else
      computer_moves
      @current_player = human.marker
    end
  end

  def human_turn?
    @current_player == human.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    sleep 1.5
    if board.match_won?
      if board.num_of_wins['human'] == Board::MATCH_WINS
        puts "#{human.name} won the match!"
      else
        puts "#{computer.name} won the match!"
      end
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset
    board.reset
    @current_player = @starting_player_for_match
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
    sleep 1
  end

  def display_play_set_again_message
    puts "Let's play another match!"
    puts ""
    sleep 1
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
    board.update_games_won(human.marker)
  end

  def main_game
    loop do
      loop do
        display_board
        player_move
        display_result
        display_play_again_message unless board.match_won?
        break if board.match_won?
        reset
      end
    break unless play_again?
    choose_marker
    find_first_player_to_move
    reset
    board.reset_number_of_games_won
    display_play_set_again_message
    end
  end

  public

  def play
    clear
    display_welcome_message
    choose_marker
    find_first_player_to_move
    main_game
    display_goodbye_message
  end
end

game = TTTGame.new
game.play



# def initialize
#   @board = Board.new
#   @human = Player.new(HUMAN_MARKER)
#   @computer = Player.new(COMPUTER_MARKER)
#   @starting_player_for_match = first_player_to_move
#   @current_player = @starting_player_for_match
# end

# def first_player_to_move
#   curr_player = nil
#   if GAME_SETTING == 'human'
#     curr_player = HUMAN_MARKER
#   elsif GAME_SETTING == 'computer'
#     curr_player = COMPUTER_MARKER
#   elsif GAME_SETTING == 'choose'
#     puts "Who would you like to go first? ( enter m for 'me' / c for computer ):"
#     answer = nil
#     loop do
#       answer = gets.chomp.downcase
#       break if ['m', 'c'].include? answer
#       puts "Must enter a 'm' or a 'c'."
#     end
#     curr_player = HUMAN_MARKER if answer == 'm'
#     curr_player = COMPUTER_MARKER if answer == 'c'
#   end
#   curr_player
# end

