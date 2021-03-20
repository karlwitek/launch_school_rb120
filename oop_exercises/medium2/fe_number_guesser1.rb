class Player
  attr_accessor :num_of_guesses

  def initialize
    @num_of_guesses = 7
  end

  def display_guesses_remaining
    puts
    if num_of_guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{num_of_guesses} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{GuessingGame::RANGE.first} and #{GuessingGame::RANGE.last}: "
      guessed_num = gets.chomp.to_i
      return guessed_num if GuessingGame::RANGE.cover?(guessed_num)
      print "Invalid guess. "
    end
  end
end

class GuessingGame
  attr_reader :player

  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:   :lose,
    low:    :lose,
    match:  :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:   "You won!",
    lose:  "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
    @player = Player.new
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    while player.num_of_guesses > 0 do
      player.display_guesses_remaining
      player.num_of_guesses -= 1 
      result = check_guess(player.obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

game = GuessingGame.new
game.play
