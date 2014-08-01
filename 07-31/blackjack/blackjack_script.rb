require 'pry'
require './blackjack.rb'

puts "Starting the game"
puts "What's your name?"
game = Game.new(Player.new(gets.chomp))
#binding.pry
# puts Player.new("Test Player").to_s
game.dealer.hand.add(game.deck.draw)
game.players.first.hand.add(game.deck.draw)
puts "#{game.players.first.name}'s' hand is #{game.players.first.hand} with a total of #{game.players.first.hand.value}"
puts "Dealer's hand is #{game.dealer.hand} with a total of #{game.dealer.hand.value}"


