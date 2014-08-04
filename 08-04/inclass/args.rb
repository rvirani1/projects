def display_name(last, first, middle=nil)
  if middle
    "#{first} #{middle}#{last}"
  else
    "#{first} #{last}"
  end
end

def sum(*numbers)
  puts "numbers is #{numbers} (a #{numbers.class})"
=begin
  total = 0
  numbers.each do |number|
    total += number
  end
  total
=end
  number.reduce { |sum, number| sum + number }

end

class Card
  RANKS = [:A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]
  SUITS = [:diamonds, :spades, :clubs, :hearts]

  def initialize(rank=nil, suit=nil)
    @rank = rank || RANKS.sample
    @suit = suit || SUITS.sample
  end
end

class KeywordCard
  def initialize hash
    @rank = hash[:rank]
    @suite = hash[:suit]
  end
end