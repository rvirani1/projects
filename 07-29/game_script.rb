require "./guessing_game"

puts "Starting the game"
game = GuessingGame.new

until game.finished?
  number = gets.chomp.to_i
  game.guess(number)
  puts game.guess(number)
end

if game.won?
  puts "You won"
else
  puts "You lost"
end