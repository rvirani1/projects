require "minitest/autorun"
require "./hangman"

describe("The hangman game") do
  it "isn't finished when it starts" do
    game = Hangman.new("cat")
    assert_equal game.finished?, false
  end

  it "lets players make a guess" do
    game = Hangman.new "cat"
    assert_equal game.guess("e"), false
  end

  it "removes letters from available letters after a guess" do
  end

  it "only lets you guess from available letters" do
  end

  it "can be solved by guessing the word" do
  end

  it "is over when you run out of guesses" do
  end

  it "displays correctly guessed letters on the board" do
  end

  it "is case insensitive" do
  end
end