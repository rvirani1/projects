require './blackjack'
require 'minitest/autorun'

describe Card do
  it "knows the values of number cards" do
    2.upto(10) do |x|
      card = Card.new(x, :S)
      assert_equal card.value, x
    end
  end

  it "knows the values of face cards" do
    [:K, :Q, :J].each do |rank|
      card = Card.new(rank, :H)
      assert_equal card.value, 10
    end
  end

  it "knows the value of an ace" do
    card = Card.new(:A, :D)
    assert_equal card.value, 11
  end
end

describe Deck do
  def setup
    @deck = Deck.new(1)
  end

  it "has the right number of cards" do
    assert_equal @deck.cards.count, 52
  end

  it "knows how many cards are left after drawing" do
    @deck.draw
    assert_equal @deck.cards.count, 51
  end

  it "tracks which cards have been drawn and which remain" do
    drawn_card = @deck.draw
    assert_equal @deck.cards.count, 51
    refute_includes @deck.cards, drawn_card
    assert_includes @deck.drawn, drawn_card
  end
end

describe Hand do
  def setup
    @hand = Hand.new
  end

  it "computes values with number cards" do
    @hand.add(Card.new(9, :H), Card.new(7, :S))
    assert_equal @hand.value, 16

    @hand.add(Card.new(4, :D))
    assert_equal @hand.value, 20
  end

  it "computes values with face cards" do
    @hand.add(Card.new(9, :H), Card.new(:K, :S))
    assert_equal @hand.value, 19
  end

  it "computes values with aces" do
    @hand.add(Card.new(:A, :H), Card.new(:K, :S))
    assert_equal @hand.value, 21

    @hand.add(Card.new(5, :S))
    assert_equal @hand.value, 16
  end

  it "can bust" do
    @hand.add(Card.new(6, :H), Card.new(:K, :S), Card.new(9, :H))
    assert @hand.busted?
  end

  it "knows a blackjack" do
    @hand.add(Card.new(:A, :H), Card.new(:K, :S))
    assert @hand.blackjack?
  end

  it "can be printed to string" do
    @hand.add(Card.new(:A, :H), Card.new(:K, :S))
    @hand.add(Card.new(5, :S))
    assert_equal @hand.to_s, 'AH, KS, 5S'
  end
end

describe Player do
  def setup
    @deck = Deck.new
    @player_no_name = Player.new
    @player = Player.new("Bob")
  end

  it "should have a specific name if given" do
    assert @player.name == "Bob"
  end

  it "should have an anonymous name if no name is given" do
    assert @player_no_name.name == "Anonymous Player"
  end

  it "should have $100 to start with" do
    assert @player.money == 100
  end

  it "should get double it's money if it wins" do
    @player.bet_amount = @player.money
    @player.win_bet
    assert_equal @player.money, (@player.bet_amount * 3)
  end

  it "should get its money back if it pushes" do
    @player.bet_amount = @player.money
    @player.push_bet
    assert_equal @player.money, (@player.bet_amount * 2)
  end

  it "should clear it's hand when asked" do
    @player.hand.add(@deck.draw)
    @player.clear_hand
    #binding.pry
    assert_equal @player.hand.to_s, ""
  end

end

describe Dealer do
  def setup
    @deck = Deck.new
    @dealer = Dealer.new
  end

  it "should clear it's hand when asked" do
    @dealer.hand.add(@deck.draw)
    @dealer.clear_hand
    assert_equal @dealer.hand.cards.length, 0
  end

  it "should not choose to hit when it has a value of 17" do
    @dealer.hand.add(Card.new(10, :H), Card.new(7, :H))
    assert_equal false, @dealer.hit?
  end

  it "should choose  to hit when it has a value of 16" do
    @dealer.hand.add(Card.new(10, :H), Card.new(6, :H))
    assert_equal true, @dealer.hit?
  end

  it "should only print one of it's cards and not both" do
    @dealer.hand.add(Card.new(10, :H), Card.new(7, :H))
    assert_equal "Dealer's side up card is 10H", @dealer.print_initial_hand
  end


end