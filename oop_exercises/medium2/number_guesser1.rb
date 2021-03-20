class GuessingGame
  attr_accessor :number, :num_of_guesses, :guessed_number

  def input_valid?(input)
    return true if (1..100).include? input
    false
  end

  def check_guess
    if guessed_number > number
      return "Your guess is too high"
    elsif guessed_number < number 
      return "Your guess is too low"
    else
      return "That's the number!"
    end
  end

  def reset
    self.num_of_guesses = 7
    self.number = rand(1..100)
  end

  def user_guess
    input = ''
    if num_of_guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{num_of_guesses} guesses remaining."
    end
    print "Enter a number between 1 and 100: "
    loop do 
      input = gets.chomp.to_i
      break if input_valid?(input)
      print "Invalid guess. Enter a number between 1 and 100: "
    end
    self.num_of_guesses -= 1
    self.guessed_number = input
    display_guess_result
  end

  def won?
    return true if number == guessed_number
    false
  end

  def zero_guesses?
    num_of_guesses == 0
  end

  def display_guess_result
    puts check_guess
  end

  def display_final_result
    puts "You won!" if won?
    puts "You have no more guesses. You lost." if zero_guesses?
  end

  def play
    reset
    loop do
      user_guess
      break if won? || zero_guesses?
    end
    display_final_result
  end
end

game = GuessingGame.new
game.play
