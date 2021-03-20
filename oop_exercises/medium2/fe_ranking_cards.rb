class Card
  include Comparable

  attr_reader :rank, :suit

  SUIT_VALUES = { 'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ranking
    case @rank
    when 'Jack'   then 11
    when 'Queen'  then 12
    when 'King'   then 13
    when 'Ace'    then 14
    else
      @rank
    end
  end

  def <=>(other)
    val = ranking <=> other.ranking
    return val if val == 1 || val == -1
    suit_value <=> other.suit_value
  end

  def suit_value
    SUIT_VALUES[suit]
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

# cards = [Card.new(3, 'Hearts'),
#          Card.new(3, 'Clubs'),
#          Card.new(3, 'Spades')]

# puts cards.min # 3 of Clubs
# puts cards.max # 3 of Spades

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

# Another example from student solutions:
# #rank_to_compare returns rank 

# def rank_to_compare
#   rank.is_a?(Integer) ? rank : FACES[rank]
# end

# def <=>(other)
#   [rank_to_compare, VAL[suit]] <=> [other.rank_to_compare, VAL[suit]]
# end

# example of writing our own < method using our own <=> method
# def <(other)
#   return true if self.<=>(other) == -1
#   return false
# end

# example: <=  
# def <=(other)
#   val = self.<=>(other)
#   return true if (val == -1) || (val == 0)
#   return false
# end
