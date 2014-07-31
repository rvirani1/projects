require 'httparty'
  MAX_MISSES = 10

class HangmanGame
  attr_reader :guessed_array, :misses

  def initialize
    #Get random word via API and store a hash where the key is the letter and the value is whether it's hidden
    @word_array = HTTParty.get('http://randomword.setgetgo.com/get.php').body.strip.downcase.split(//)
    puts @word_array.join("")
    puts @word_array.count
    @guessed_array = []
    @misses = 0
  end

  def hangman_image_url
    "http://www.riazvirani.info/hangman/hang#{@misses}.gif"
  end

  def guess_letter(user_letter)
    @guessed_array << user_letter
    @misses += 1 unless @word_array.include?(user_letter)
    puts "Number of misses: " + @misses.to_s
  end

  def word_display
    output = ""
    #For each letter in the word, check to see if the letter is in the guessed array, If yes, then show it, if no, then show a blank
    @word_array.each do |word_letter|
      output += " "
      if @guessed_array.include?(word_letter)
        output += word_letter
      else
        output += "_"
      end
    end
    return output
  end

  def missed_word_display
    #For each letter guessed array, check to see if the letter is in the word_array, if not, then add it to a string to be returned
    output = ""
    @guessed_array.each do |guessed_letter|
      output += " "
      output += guessed_letter unless @word_array.include?(guessed_letter) || output.include?(guessed_letter)
    end
    output
  end

  def won?
    !word_display.include?("_")
  end

  def lost?
    @misses == MAX_MISSES
  end
end