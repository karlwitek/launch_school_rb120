class GuessingGame

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

  def initialize(start_num, end_num)
    @secret_number = nil
    @range = (start_num..end_num)
    @number_of_guesses = find_number_of_guesses(start_num, end_num)
  end

  def find_number_of_guesses(start_num, end_num)
    n = end_num - start_num
    Math.log2(n).to_i + 1
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(@range)
  end

  def play_game
    result = nil
    @number_of_guesses .downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      return guess if @range.cover?(guess)
      print "Invalid guess. "
    end
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

game = GuessingGame.new(100, 1000)
game.play
