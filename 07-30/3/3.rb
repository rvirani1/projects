def letter_counter(input)
  output = Hash.new(0)
  input.each_char do|letter|
    output[letter.to_sym] += 1
  end
  return output
end

#number of lower case 't's in homework is 98
#number of upper case 'T's in homework is 4