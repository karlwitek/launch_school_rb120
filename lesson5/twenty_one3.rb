class Participant
  attr_accessor :hand
  attr_reader :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def hit(new_card)
    hand << new_card
  end

  def total_for_hand
    total = hand.reduce(0) { |sum, card| sum + card.value }
    if total > 21
      number_of_aces = hand.select { |card| card.value == 11 }.count
      number_of_aces.times do
        total -= 10
        break if total <= 21
      end
    end
    total
  end

  def show_hand
    puts "------ #{name}'s Hand -----"
    puts ""
    hand.each do |card|
      puts "  #{card}  "
    end
    puts ""
  end

  def busted?
    total_for_hand > 21
  end

  def >(other)
    total_for_hand > other.total_for_hand
  end

  def add_to_hand(deck)
    next_card = deck.add_card
    hit(next_card)
    puts "#{name} hits #{next_card}"
  end
end

class Player < Participant
  def show_first_two_cards_dealt
    first_card = hand.first
    second_card = hand.last
    print "#{name} is dealt:  "
    puts "#{first_card} and #{second_card}"
    puts ""
  end
end

class Dealer < Participant
  def show_first_two_cards_dealt
    first_card = hand.first
    puts "#{name} has #{first_card} showing and one card face down"
    puts ""
  end

  def reveal_hand
    down_card = hand.last
    puts "#{name} turns over #{down_card}"
    puts "#{name} has #{total_for_hand}"
  end
end

class Card
  attr_reader :value, :suit, :name

  SUITS = ['H', 'D', 'S', 'C']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, rank)
    @value = get_card_value(rank)
    @suit = get_card_suit(suit)
    @name = get_card_name(rank)
  end

  def get_card_value(rank)
    case rank
    when 'A'  then 11
    when 'K'  then 10
    when 'Q'  then 10
    when 'J'  then 10
    else
      rank.to_i
    end
  end

  def get_card_suit(suit)
    case suit
    when 'H'  then 'Hearts'
    when 'D'  then 'Diamonds'
    when 'S'  then 'Spades'
    when 'C'  then 'Clubs'
    end
  end

  def get_card_name(rank)
    case rank
    when 'A'  then 'Ace'
    when 'K'  then 'King'
    when 'Q'  then 'Queen'
    when 'J'  then 'Jack'
    else
      rank
    end
  end

  def to_s
    "the #{name} of #{suit}"
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end

    shuffle_deck!
  end

  def shuffle_deck!
    cards.shuffle!
  end

  def add_card
    cards.pop
  end
end

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @player = Player.new('Joe')
    @dealer = Dealer.new('The Dealer')
    @deck = Deck.new
  end

  def display_welcome_message
    puts ""
    puts "Welcome to BlackJack! "
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing BlackJack! Goodbye."
    puts ""
  end

  def deal_first_two_cards
    2.times do
      player.hit(deck.add_card)
      dealer.hit(deck.add_card)
    end
  end

  def show_first_two_cards
    player.show_first_two_cards_dealt
    dealer.show_first_two_cards_dealt
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def player_turn
    answer = nil
    puts "#{player.name} has #{player.total_for_hand}"
    loop do
      puts "Do you want to hit or stay? (enter 'h' or 's') "
      loop do
        answer = gets.chomp.downcase
        break if ['h', 's'].include? answer
        puts "Please enter h or s"
      end
      if answer == 's'
        player.show_hand
        break
      elsif answer == 'h'
        player.add_to_hand(deck)
        puts "#{player.name} has #{player.total_for_hand}"
      end
      break if player.busted?
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def dealer_turn
    dealer.reveal_hand
    if dealer.total_for_hand < 17
      loop do
        dealer.add_to_hand(deck)
        break if dealer.total_for_hand > 16
      end
      puts "#{dealer.name} has #{dealer.total_for_hand}"
    end
  end

  def detect_winner
    if player > dealer
      "#{player.name} wins!"
    elsif dealer > player
      "#{dealer.name} wins!"
    else
      "It's a tie."
    end
  end

  def display_winner_of_hand
    if player.busted?
      puts "#{player.name} BUSTED!!  #{dealer.name} wins"
    elsif dealer.busted?
      puts "#{dealer.name} BUSTED!!  #{player.name} wins!"
    else
      puts detect_winner
    end
  end

  def reset
    @deck = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
    end
    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      deal_first_two_cards
      show_first_two_cards
      player_turn
      dealer_turn unless player.busted?
      display_winner_of_hand
      reset
      break unless play_again?
    end

    display_goodbye_message
  end
end

twenty_one = Game.new
twenty_one.play
