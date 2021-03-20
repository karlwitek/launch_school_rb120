module Hand
  def show_hand
    puts "----- #{name}'s Hand -----"
    cards.each do |card|
      puts "  #{card} "
    end
    puts "  Total:  #{total}"
    puts ""
  end

  def total
    total = 0
    cards.each do |card|
      if card.ace?
        total += 11
      elsif card.jack? || card.queen? || card.king?
        total += 10
      else
        total += card.rank.to_i
      end
    end

    # correct for Aces
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

class Card

  RANK = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  SUIT = ['H', 'D', 'S', 'C']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "The #{rank} of #{suit}"
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

  def deal_one
    cards.pop
  end
end

class Participant
  attr_accessor :name, :cards

  include Hand

  def initialize
    @cards = []
    set_name
  end
end


class Player < Participant

  def set_name
    name = ''
    loop do
      puts "Enter your name"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end

  def show_flop
    show_hand
  end
end

class Dealer < Participant

  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
  
  def set_name
    self.name = ROBOTS.sample
  end

  def show_flop
    puts "----- #{name}'s Hand -----"
    puts "#{cards.first}"
    puts " ?? "
    puts ""
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    puts "#{player.name}'s turn..."

    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = nil
      loop do
        answer = gets.chomp.downcase
        break if ['h', 's'].include?(answer)
        puts "Sorry, must enter 'h' or 's' "
      end

      if answer == 's'
        puts "#{player.name} stays!"
        break
      elsif player.busted?
        break
      else
      # show update only for hit
        player.add_card(deck.deal_one)
        puts "#{player.name} hits!"
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."

    loop do
      if dealer.total >= 17 && !dealer.busted?
        puts "#{dealer.name} stays!"
        break
      elsif dealer.busted?
        break
      else
        puts "#{dealer.name} hits!"
        dealer.add_card(deck.deal_one)
      end
    end
  end

  def show_busted
    if player.busted?
      puts "It looks like #{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "It looks like #{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def show_result
    if player.total > dealer.total
      puts "It looks like #{player.name} wins!"
    elsif player.total > dealer.total
      puts "It looks like #{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again?"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def play
    loop do
      system 'cls'
      deal_cards
      show_flop

      player_turn
      if player.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      dealer_turn
      if dealer.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      # both stayed
      show_cards
      show_result
      play_again? ? reset : break
    end

    puts "Thank you for playing Twenty-One. Goodbye!"
  end
end

game = Game.new
game.play

