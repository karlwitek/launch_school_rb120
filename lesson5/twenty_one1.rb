module Playable
  attr_accessor :hand

  def total_for_hand
    value = 0
    hand.each do |card|
      if card.ace?
        value += 11
      elsif card.king? || card.queen? || card.jack?
        value += 10
      else 
        value += card.rank.to_i
      end
    end
    number_of_aces_in_hand = hand.select(&:ace?).count
    if number_of_aces_in_hand > 0 && value > 21
      number_of_aces_in_hand.times do
        value -= 10
        break if value <= 21
      end
    end
    value
  end

  def hit(one_card)
    hand << one_card
  end

  def busted?
    total_for_hand > 21
  end

  def >(other)
    total_for_hand > other.total_for_hand
  end
end

class Player
  include Playable

  def initialize
    @hand = []
  end

  def display_first_two_cards
    puts ''
    puts "You have a #{card} and a #{card}"
  end
end

class Dealer

  attr_reader :name

  include Playable

  def initialize(name)
    @name = name
    @hand = []
  end

  def display_first_two_cards
    puts "#{name} has a #{card} showing and " +
         "one card is face down."
  end
end

class Card
  SUIT = ['H', 'D', 'S', 'C']
  RANK = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit 
  end

  def to_s
    "the #{rank} of #{suit}"
  end

  def rank
    case @rank
    when 'J'  then 'Jack'
    when 'Q'  then 'Queen'
    when 'K'  then 'King'
    when 'A'  then 'Ace'
    else
      @rank
    end
  end

  def suit
    case @suit
    when 'H'  then 'Hearts'
    when 'D'  then 'Diamonds'
    when 'S'  then 'Spades'
    when 'C'  then 'Clubs'
    end
  end

  def ace?
    rank == 'Ace'
  end

  def king?
    rank == 'King'
  end

  def queen?
    rank == 'Queen'
  end

  def jack?
    rank == 'Jack'
  end
end

class Deck

  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUIT.each do |suit|
      Card::RANK.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    shuffle_deck!
  end

  def shuffle_deck!
    cards.shuffle!
  end

  def get_one_random_card
    cards.pop
  end

  def deal_first_two_cards
    [get_one_random_card, get_one_random_card]
  end
end

class Game
  DEALER_NAME = 'The Dealer'

  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new(DEALER_NAME)
  end

  def play
    display_welcome_message
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn
      display_result
      break unless play_again?
    end
    display_goodbye_message
  end

  def reset
    cards = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def deal_cards
    player.hand = deck.deal_first_two_cards
    dealer.hand = deck.deal_first_two_cards
  end

  def show_initial_cards
    player.display_first_two_cards
    dealer.display_first_two_cards
  end

  def player_turn
    answer = nil
    loop do
      puts "The total of your hand is: #{player.total_for_hand}"
      puts "Would you like to hit or stay? (enter 'h' or 's') "
      loop do
        answer = gets.chomp
        break if ['h', 's'].include? answer
        puts "Please enter a 'h' or 's' "
      end
      if answer == 'h'
        player.hit(deck.get_one_random_card)
        puts "The card is a #{player.hand.last[0]} of #{player.hand.last[1].to_s}"
        if player.busted?
          puts " BUSTED!!! "
          break
        end
      else
        break
      end
    end
  end

  def dealer_turn
    if !player.busted?
      puts "#{dealer.name} turns over a #{dealer.hand.last[0]} for #{dealer.total_for_hand} total"
      if dealer.total_for_hand > 16 
        puts "#{dealer.name} stays"
      else
        loop do
          sleep 1
          dealer.hit(deck.get_one_random_card)
          puts "#{dealer.name} hits a #{dealer.hand.last[0]}"
          break if dealer.total_for_hand > 16
        end
        puts "#{dealer.name} has #{dealer.total_for_hand}"
        puts "#{dealer.name} BUSTS!!! " if dealer.busted?
      end
    end
  end

  def display_result
    if player.busted?
      puts "#{dealer.name} wins"
    elsif dealer.busted?
      puts "You Win!"
    elsif dealer > player
      puts "#{dealer.name} wins."
    elsif player > dealer
      puts "You Win!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    puts "Would you like to play again? (y or n)"
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Please enter a 'y' or 'n' "
    end
    answer == 'y'
  end

  def display_welcome_message
    puts ''
    puts "Welcome to BlackJack!"
  end

  def display_goodbye_message
    puts "Thank you for playing BlackJack."
    puts ""
  end
end

Game.new.play
