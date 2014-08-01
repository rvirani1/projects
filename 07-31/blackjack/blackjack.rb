require 'pry'

=begin
### 2. Blackjack

Write a script to play blackjack.

                           Level 1:
    * The program should be fully object-oriented
* The player starts with $100 and bets are $10
* The only options are hit and stand
* Players can play as long as they can afford it, and can
leave after any round.
                    * The dealer reshuffles after every round
* The included test file should pass (defining Card, Deck, and Hand)
* Push your homework up to your repository on github

Level 2:
    * Ignore the included spec file, and test drive development yourself
* Write specs for any other classes you use (Player? Game?)

                Level 3:
                    * Allow variable bets
                * Allow double-downs
                * Dealer only reshuffles when the deck runs out
                * Allow for multiple decks
=end

SUITS = [:H, :S, :C, :D]
RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]
BET = 10

class Game
  attr_accessor :players, :deck, :dealer
  def initialize(*players)
    @deck = Deck.new
    @amount_bet = 0
    @players = players || []
    @dealer = Dealer.new
  end
end

class Card
  attr_reader :rank, :suit
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    case @rank
      when 2..10
        @rank
      when :J
        10
      when :Q
        10
      when :K
        10
      when :A
        11
    end
  end

  def to_s
    @rank.to_s + @suit.to_s
  end
end



class Deck
  attr_reader :cards, :drawn
  def initialize
    @cards = []
    @drawn = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end

  def draw
    card = @cards.pop
    @drawn << card
    card
  end
end

class Hand
  attr_reader :cards
  def initialize
    @cards = []
  end

  def add(*new_cards)
    new_cards.each do |new_card|
      @cards << new_card
    end
  end

  def value
    total_value = 0
    @cards.each do |card|
      total_value += card.value
    end
    num_aces.times do
      total_value -= 10 if total_value > 21
    end
    total_value
  end

  def busted?
    value() > 21
  end

  def blackjack?
    value() == 21
  end

  def num_aces
    num_aces = 0
    @cards.each do |card|
      num_aces += 1 if card.rank == :A
    end
    num_aces
  end

  def to_s
    array = []
    @cards.each do |card|
      array << card.to_s
    end
    array.join(", ")
  end
end

class Dealer
  attr_accessor :hand, :lost

  def initialize
    @hand = Hand.new()
    @lost = false
  end

  def hit?
    @hand.value <= 17
  end

  def hit(card)
    @hand.add(card)
  end

end

class Player
  attr_accessor :name, :money, :left, :lost, :hand

  def initialize(name)
    @name = name
    @money = 100
    @hand = Hand.new()
    @left = false
    @lost = false
  end

  def hit(card)
    @hand.add(card)
  end

  def standing?
    !(@left || @lost)
  end

  def to_s
    puts "#{@name}: #{@money}"
  end

  def bet(amount)
    @money -= amount
  end
end
