require './hangman_art'

class Hangman

  def initialize answer
    @answer = answer
    @misses_remaining = 6
    @guessed = []
  end

  def board
    result = ""
    @answer.split("").each do |char|
      if @guessed.include?(char)
        result += char
      else
        result += "_"
      end
    end
  end

  def guess(letter)
    @guessed << letter

  end

  def finished?
    won? || lost?
  end

  def won?
    !board.include?("_")
  end

  def lost?
    @misses_remaining.zero?
  end
end
