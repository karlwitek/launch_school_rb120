VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

class Rock
  def >(other)
    other.class == Scissors || other.class == Lizard
  end

  def <(other)
    other.class == Paper || other.class == Spock
  end

  def to_s
    'rock'
  end
end

class Paper
  def >(other)
    other.class == Rock || other.class == Spock
  end

  def <(other)
    other.class == Lizard || other.class == Scissors
  end

  def to_s
    'paper'
  end
end

class Scissors
  def >(other)
    other.class == Paper || other.class == Lizard
  end

  def <(other)
    other.class == Rock || other.class == Spock
  end

  def to_s
    'scissors'
  end
end

class Lizard
  def >(other)
    other.class == Paper || other.class == Spock
  end

  def <(other)
    other.class == Rock || other.class == Scissors
  end

  def to_s
    'lizard'
  end
end

class Spock
  def >(other)
    other.class == Scissors || other.class == Rock
  end

  def <(other)
    other.class == Lizard || other.class == Paper
  end

  def to_s
    'spock'
  end
end

class Player
  attr_accessor :move, :name, :move_history

  def initialize
    @move_history = []
    set_name
  end

  def record_move
    move_history << "#{self.move}"
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissor, lizard or spock."
      choice = gets.chomp
      break if VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    case choice
    when 'rock'     then self.move = Rock.new
    when 'paper'    then self.move = Paper.new 
    when 'scissors' then self.move = Scissors.new
    when 'lizard'   then self.move = Lizard.new
    when 'spock'    then self.move = Spock.new
    end
  end
end
  
  class Computer < Player
    def set_name
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end

    def choose
      comp_move = VALUES.sample
      case comp_move
      when 'rock'     then self.move = Rock.new
      when 'paper'    then self.move = Paper.new 
      when 'scissors' then self.move = Scissors.new
      when 'lizard'   then self.move = Lizard.new
      when 'spock'    then self.move = Spock.new
      end
    end
  end

  #Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thank you for playing. Goodbye."
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie."
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def display_move_history
    print "#{human.name} chose:"
    human.move_history.each do |mv|
      print ' ' + mv
    end
    puts " "
    print "#{computer.name} chose:"
    computer.move_history.each do |mv|
      print ' ' + mv
    end
    puts ' '
  end

  def play
    display_welcome_message
    loop do
      human.choose
      human.record_move
      computer.choose
      computer.record_move
      display_moves
      display_winner
      break unless play_again?
    end
    display_move_history
    display_goodbye_message
  end
end

RPSGame.new.play
