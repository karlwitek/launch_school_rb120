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
  attr_accessor :move, :name

  def initialize
    set_name
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
    attr_accessor :move_percentage

    MOVE_WEIGHT = { 'R2D2'=> { 'r' => 1..20, 'p' => 21..40, 'sc' => 41..60, 'l' => 61..80, 'sp' => 81..100 },
                    'Hal'=> { 'r' => 1..50, 'p' => 51..75, 'sc' => 76..100, 'l' => 0..0, 'sp' => 0..0 },
                    'Chappie'=> { 'r' => 1..70, 'p' => 71..75, 'sc' => 76..80, 'l' => 81..90, 'sp' => 91..100 },
                    'Sonny'=> { 'r' => 1..10, 'p' => 11..30, 'sc' => 31..60, 'l' => 61..100, 'sp' => 0..0 },
                    'Number 5' => { 'r' => 1..10, 'p' => 11..20, 'sc' => 21..30, 'l' => 31..70, 'sp' => 71..100 } }

    def set_name
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end

    def choose
      self.move_percentage = MOVE_WEIGHT[name]
      num = rand(1..100)
      one_pair = move_percentage.select { |k, v| v.include?(num) }
      comp_move = one_pair.keys[0]

      case comp_move
      when 'r'        then self.move = Rock.new
      when 'p'       then self.move = Paper.new 
      when 'sc'    then self.move = Scissors.new
      when 'l'      then self.move = Lizard.new
      when 'sp'       then self.move = Spock.new
      end
    end
  end

class History
  attr_reader :human_moves, :computer_moves

  def initialize
    @human_moves = []
    @computer_moves = []
  end

  def save_move(human, computer)
    human_moves << "#{human.move}"
    computer_moves << "#{computer.move}"
  end

  def display_move_history(human, computer)
    print "#{human.name} chose:"
    human_moves.each do |mv|
      print ' ' + mv
    end
    puts " "
    print "#{computer.name} chose:"
    computer_moves.each do |mv|
      print ' ' + mv
    end
    puts ' '
  end
end

#Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @history = History.new
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

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      history.save_move(human, computer)
      display_moves
      display_winner
      break unless play_again?
    end
    history.display_move_history(human, computer)
    display_goodbye_message
  end
end

RPSGame.new.play



# class Computer < Player
#   def set_name
#     self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
#   end

#   def choose
#     num = rand(1..100)
#     if name == 'R2D2'
#       hash = { 'r' => 1..20, 'p' => 21..40, 'sc' => 41..60, 'l' => 61..80, 'sp' => 81..100 }
#     elsif name == 'Hal'
#       hash = { 'r' => 1..50, 'p' => 51..75, 'sc' => 76..100, 'l' => 0..0, 'sp' => 0..0 }
#     elsif name == 'Chappie'
#       hash = { 'r' => 1..70, 'p' => 71..75, 'sc' => 76..80, 'l' => 81..90, 'sp' => 91..100 }
#     elsif name == 'Sonny'
#       hash = { 'r' => 1..10, 'p' => 11..30, 'sc' => 31..60, 'l' => 61..100, 'sp' => 0..0 }
#     elsif name == 'Number 5'
#       hash = { 'r' => 1..10, 'p' => 11..20, 'sc' => 21..30, 'l' => 31..70, 'sp' => 71..100 }
#     end
#     one_pair = hash.select { |k, v| v.include?(num) }
#     comp_move = one_pair.keys[0]
