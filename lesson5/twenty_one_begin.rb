# Twenty-One is a card game consisting of a dealer and a player, where the participants try
# to get as close to 21 as possible without going over.

# Here is an overview of the game:
# - Both participants are initially dealt 2 cards from a 52-card deck.
# - The player takes the first turn, and can "hit" or "stay".
# - If the player busts, he loses. If he stays, it's the dealer's turn.
# - The dealer must hit until his cards add up to at least 17.
# - If he busts, the player wins. If both player and dealer stays, then the highest total wins.
# - If both totals are equal, then it's a tie, and nobody wins.

# Nouns: card, player, dealer, participant, deck, game, total
# Verbs: deal, hit, stay, busts

# the 'total' here is not going to be a class, but is actually an attribute within a class.
# It's not a noun that performs actions, but a property of some other noun.
# Can also think of it as a verb: 'calculate_total'

# Write out classes and organize the verbs:

# Player
# - hit
# - stay
# - busted?
# - total
# Dealer
# - hit
# - stay
# - busted?
# - total
# - deal (should this be here, or in Deck?)
# Participant
# Deck
# - deal (should this be here, or in Dealer?)
# Card
# Game
# - start

# Extract redunduncy in the Player and Dealer class to a super-class? 'Participant' ?
# LS uses a module called 'Hand' that will capture this redunduncy. (not the only way)
# Spike:

# class Player
#   def initialize
#     # what would the "data" or "states" of a Player object entail?
#     # maybe cards? a name?
#   end

#   def hit
#   end

#   def stay
#   end

#   def busted?
#   end

#   def total
#     # definitely looks like we need to know about "cards" to produce some total
#   end
# end

# class Dealer
#   def initialize
#     # seems like very similar to Player... do we even need this?
#   end

#   def deal
#     # does the dealer or the deck deal?
#   end

#   def hit
#   end

#   def stay
#   end

#   def busted?
#   end

#   def total
#   end
# end

# class Participant
#   # what goes in here? all the redundant behaviors from Player and Dealer?
# end

# class Deck
#   def initialize
#     # obviously, we need some data structure to keep track of cards
#     # array, hash, something else?
#   end

#   def deal
#     # does the dealer or the deck deal?
#   end
# end

# class Card
#   def initialize
#     # what are the "states" of a card?
#   end
# end

# class Game
#   def start
#     # what's the sequence of steps to execute the game play?
#   end
# end

# Game.new.start

# Lots of details to be fleshed out. Start with Game#start method that will drive the 
# implementation fo the other classes. (methods we wished existed)

# class Game
#   def start
#     deal_cards
#     show_initial_cards
#     player_turn
#     dealer_turn
#     show_result
#   end
# end

# Work on solution:
# (reference implementation next)

