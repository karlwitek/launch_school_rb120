# write a short description of the game:
# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
# marking a square. The first player to mark 3 squares in a row wins.

# Nouns: board, player, square, grid
# Verbs: play, mark

# Board
# Square
# Player
# - mark
# - play
# the 'grid' noun was omitted because it is the same as 'board'. Doesn't appear to be any verbs for 'Board' or
# 'Square'. (seems awkward). Just a starting point for us to 'spike' (explore)

# write our classes. Create an initialize method, start to think about possible 'states' for the objects of the
# class.

class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (ie, 'X' or 'O')
  end

  def mark

  end

  def play

  end
end

# Nothing is clear yet. Don't know if we need a 'Square' or 'Player' yet. One class we do need is some sort
# of orchestration engine:

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

# The above methods, if existed, and did what we expect, constitue the major steps of the Tic Tac Toe game.
# We have enough scaffolding code now to start exploring deeper.

# we'll kick off the game like this:
game = TTTGame.new
game.play

# Given this code above, looks like we should remove the Player#play method.  Flesh out the sequence of the 
# TTTGame#play method by invoking the methods that we wished existed:

