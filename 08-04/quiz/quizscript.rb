require './quiz.rb'
require 'yaml'
require 'pry'

QuestionsList = YAML.load_file("questions.yml")

game = QuizGame.new
QuestionsList.each do |question|
  game.add_question(Question.new(question))
end
game.play

