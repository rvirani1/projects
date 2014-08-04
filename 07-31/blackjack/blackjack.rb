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
  attr_reader :players, :deck, :dealer
  def initialize(num_of_decks=1)
    @deck = Deck.new(num_of_decks)
    @players = []
    @dealer = Dealer.new
  end

  def new_player(index)
    puts ""
    puts "What's the #{ordinalize(index)} player's name?"
    @players << Player.new(gets.chomp)
  end

  def play_round
    get_bets
    if active_players_in_round?
      deal_cards
      unless @dealer.hand.blackjack?
        @players.each do |player|
          if player.active
            player.play(@deck)
          end
        end
      end
      @dealer.play(@deck)
      evaluate_round
    end
  end

  def get_bets
    @players.each do |player|
      player.bet if player.active
    end
    puts "All players have bet. The pot is now worth $#{pot}"
    puts ""
  end

  def deal_cards
    puts ""
    puts "Dealing Cards"
    @dealer.clear_hand
    @dealer.hand.add(@deck.draw, @deck.draw)
    @dealer.print_initial_hand
    @players.each do |player|
      if player.active
        player.clear_hand
        player.hand.add(@deck.draw, @deck.draw)
        player.print_hand
      end

    end
  end

  def active_players_in_round?
    @players.each do |player|
      return true if player.active
    end
    false
  end

  def evaluate_round
    @players.each do |player|
      if ((player.hand.value > @dealer.hand.value) || @dealer.hand.busted?) && !player.hand.busted?
        player.win_bet
        puts "#{player.name} won this round. They bet #{player.bet_amount}, so they now have $#{player.money}"
      elsif (player.hand.value == @dealer.hand.value) && !player.hand.busted?
        player.push_bet
        puts "#{player.name} got a push. They bet #{player.bet_amount}, so they now have $#{player.money}"
      else
        puts "#{player.name} lost this round. They bet #{player.bet_amount}, so they now have $#{player.money}"
        player.active = false if player.money == 0
      end
    end
  end

  def pot
    round_pot = 0
    @players.each do |player|
      round_pot += player.bet_amount
    end
    round_pot
  end

  def active?
    @players.each do |player|
        return true if player.active
    end
    false
  end

  def ordinalize(int)
    case int
      when 1; "#{int}st"
      when 2; "#{int}nd"
      when 3; "#{int}rd"
      else    "#{int}th"
    end
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
  def initialize(num_of_decks)
    @cards = []
    @drawn = []
    num_of_decks.times do
      SUITS.each do |suit|
        RANKS.each do |rank|
          @cards << Card.new(rank, suit)
        end
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
  attr_accessor :cards, :finished
  def initialize
    @cards = []
    @finished = false
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

  def first
    @cards.first
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

  def print_initial_hand
    puts "Dealer's side up card is #{@hand.first}"
  end

  def play(deck)
    puts "Starting dealer's turn for this hand"
    if @hand.blackjack?
      @hand.finished = true
      puts "Dealer got a blackjack"
    end
    until @hand.value >= 17 || @hand.finished
      @hand.add(deck.draw)
    end
    puts "The dealer's hand is #{@hand} with a total of #{@hand.value}"
  end

  def clear_hand
    @hand = Hand.new
  end
end

class Player
  attr_accessor :name, :money, :standing, :active, :hand, :bet_amount

  def initialize(name)
    @name = name
    @money = 100
    @hand = Hand.new()
    @standing = false
    @active = true
    @bet_amount = 0
  end

  def hit(card)
    @hand.add(card)
  end

  def standing?
    !(@standing || @active)
  end

  def to_s
    puts "#{@name}: #{@money}"
  end


  def bet
    @bet_amount = 0
    puts "#{@name}, how much would you like to bet? You currently have $#{@money}. Enter 0 to quit game"
    bet_input = gets.chomp.to_i
    while @money < bet_input
      puts "#{@name} can't bet more than #{@name} has"
      bet_input = gets.chomp.to_i
    end
    if bet_input == 0
      @active = false
    elsif @money >= bet_input
      puts "#{@name} just bet $#{bet_input}"
      @bet_amount = bet_input
      @money -= bet_input
    end
  end

  def print_hand
    puts "#{@name}'s' hand is #{@hand} with a total of #{@hand.value}"
  end

  def play(deck)
    if @hand.blackjack?
      puts "#{@name} got a blackjack!"
    end

    until @hand.busted? || @hand.finished || @hand.blackjack? || !@active
      puts "Would #{@name} like to hit or stand?"
      case gets.chomp
        when "hit"
          puts "#{@name} decided to hit."
          @hand.add(deck.draw)
          puts "#{@name} hand is now #{@hand} with a value of #{@hand.value}"
        when "stand"
          puts "#{@name} decided to stand"
          @hand.finished = true
          puts "#{@name} hand is #{@hand} with a value of #{@hand.value}"
        else
          puts "#{@name} didn't enter hit or stand"
      end

      if @hand.blackjack?
        puts "#{@name} got a blackjack!"
      elsif @hand.busted?
        puts "#{@name} busted!"
      end

    end
  end

  def clear_hand
    @hand = Hand.new
  end

  def win_bet
    @money += (2 * @bet_amount)
    # @bet_amount = 0
  end

  def push_bet
    @money += @bet_amount
    # @bet_amount = 0
  end
end
