class Card
  include Comparable
  attr_reader :rank, :suit, :value

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = VALUES.fetch(rank, rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

class PokerHand
  attr_reader :hand, :suit_count, :rank_count, :rank_unique_size, :suit_unique_size, :spread

  def initialize(deck)
    @hand = []
    5.times { hand << deck.draw }
    @suit_count = find_suit_count.first
    @suit_unique_size = find_suit_count.last
    @rank_count = find_rank_count.first
    @rank_unique_size = find_rank_count.last
    @spread = find_spread
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?       then 'Royal flush'
    when straight_flush?    then 'Straight flush'
    when four_of_a_kind?    then 'Four of a kind'
    when full_house?        then 'Full house'
    when flush?             then 'Flush'
    when straight?          then 'Straight'
    when three_of_a_kind?   then 'Three of a kind'
    when two_pair?          then 'Two pair'
    when pair?              then 'Pair'
    else                         'High card'
    end
  end

  private

  def find_spread
    low, high = hand.minmax
    high.value - low.value
  end

  def find_suit_count
    high_suit_count = 0
    suit_arr = hand.map { |crd| crd.suit }
    suit_arr.each do |suit|
      curr_count = suit_arr.count(suit)
      high_suit_count = curr_count if curr_count > high_suit_count
    end
    [high_suit_count, suit_arr.uniq.size]
  end

  def find_rank_count
    high_rank_count = 0
    rank_arr = hand.map { |crd| crd.rank }
    rank_arr.each do |rank|
      curr_count = rank_arr.count(rank)
      high_rank_count = curr_count if curr_count > high_rank_count
    end
    [high_rank_count, rank_arr.uniq.size]
  end
  
  def royal_flush?
    return true if spread == 4 && suit_count == 5 && hand.min.rank == 10
    false  
  end

  def straight_flush?
    return true if spread == 4 && suit_count == 5 && hand.min.rank != 10
    false
  end

  def four_of_a_kind?
    return true if rank_count == 4
    false
  end

  def full_house?
    return true if rank_count == 3 && rank_unique_size == 2
    false
  end

  def flush?
    return true if suit_count == 5 && spread > 4  
    false
  end

  def straight?
    return true if spread == 4 && rank_unique_size == 5 && suit_count < 5
    false
  end

  def three_of_a_kind?
    return true if rank_count == 3 && rank_unique_size > 2
    false
  end

  def two_pair?
    return true if rank_count == 2 && rank_unique_size == 3
    false
  end

  def pair?
    return true if rank_count == 2 && rank_unique_size == 4
    false
  end
end

class Array
  alias_method :draw, :pop
end

hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'


hand2 = PokerHand.new(Deck.new)
puts hand2.evaluate

hand3 = PokerHand.new(Deck.new)
puts hand3.evaluate
