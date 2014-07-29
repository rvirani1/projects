year = ARGV.first.to_i

puts "You input #{year}"

def divisible?(num, div)
  num % div == 0
end

if (divisible?(year, 4) && !divisible(year, 20)) || divisible?(year, 100)
  puts "#{year} is a leap year"
end