require 'pry'
require './blackjack.rb'

#game initialization
puts "Starting the game"
puts "How many decks are you playing with?"
game = Game.new(gets.chomp.to_i)
puts "How many players are playing?"
number_of_players = gets.chomp.to_i
(1..number_of_players).each do |x|
  game.new_player(x)
end

## hand loop
puts "Starting the game"
while game.active?
  puts "Starting a round"
  game.play_round
  puts "Finishing a round"
end
puts "Exiting the game"

