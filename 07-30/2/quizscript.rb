require './quiz.rb'
require 'pry'

puts "Loading quiz questions"
Questions = [
    {
        question: "Why did the chicken cross the road?",
        choices: [
                      "Why does anyone do anything?",
                      "To get to the other side",
                      "Something something something YOUR MOM",
                      "Mu"
                  ],
        answer: 1
    }
]

game = QuizGame.new(Questions)
game.play

