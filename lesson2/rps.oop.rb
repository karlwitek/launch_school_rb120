# (lecture) In OOP, we don't think about the game flow logic at all. It's about organizing and modularizing the code into
# a cohesive structure - classes.  After we come up with the initial class definitions, the final step is to orchestrate
# the flow of the program using objects instantiated from the classes.

# Rock, Paper, Scissors is a two-player game where each player chooses one of three possible moves: rock, paper, scissors.
# The chosen moves will then be compared to see who wins, according to the following rules:
# - rock beats scissors
# - scissors beats paper
# - paper beats rock
# If the players chose the same move, then it's a tie.

# Try to extract the major nouns and verbs:
# Nouns: player, move, rule
# Verbs: choose, compare

# (ignored 'rock', 'paper', 'scissors'. They are variations on a move-almost like different states of a move.) Therefore,
# we capture the major noun: move.
# Organize the verbs with the nouns. (not obvious where the 'compare' verb goes.)
# Player
# - choose
# Move
# Rule

# - compare

class Player
  def initialize
    # a name? a move?
  end

  def choose
  end

end

class Rule
  def initialize
    # not sure what the 'state' of a rule object should be yet
  end
end

# not sure where 'compare' goes yet
def compare(move1, move2)

end

# initial 'skeleton' classes and methods to start with
# After we're done organizing nouns and verbs into classes, we need an 'engine' of some sort to orchestrate the objects.
# This is where the procedural flow should be. Let's call the 'engine' class RPSGame.  We want an easy interface to kick
# things off, so perhaps to play the game, we just instantiate an object and call a method called 'play':

# RPSGame.new.play

# Given that interface, start the class definition:

class RPSGame
  def initialize

  end

  def play

  end
end

# starting from that skeleton, we can start to think about what objects are required in the play method to 
# facilitate the game.

def play
  display_welcome_message
  human_choose_move
  computer_choose_move
  display_winner
  display_goodbye_message
end

# There's a redundant 'choose_move' part.  This ties into our Player class, which has a choose method.  
# What if human and computer were both objects of the Player class? They'd both immediately have the 
# Player#choose method. With that insight, we update the RPSGame class definition:

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end

# How to use the Move class and the Rule class in our game? Maybe those classes aren't needed at all.




