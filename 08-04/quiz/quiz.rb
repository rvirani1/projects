require 'pry'
require 'highline/import'
Letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]

class Question
  attr_reader :question, :choices, :answer
  def initialize hash
    @question = hash[:question]
    @choices = hash[:choices]
    @answer = hash[:answer]
  end

  def to_s
    @question
  end
end

class QuizGame
  def initialize
    @questions = []
    @correct_questions = []
    @incorrect_questions = []
  end

  def add_question(question)
    @questions << question
  end

  def play
    @questions.each_with_index do |current_question, question_idx|
      response = display_question(current_question, question_idx)
      evaluate_answer(current_question, response)
      puts "Answered: #{question_idx + 1} Correct: #{@correct_questions.count} Incorrect: #{@incorrect_questions.count}"
    end
    final_results

  end

  def final_results
    puts " "
    puts "Correct Questions"
    @correct_questions.each do |question|
      puts question_prompt(question)
      puts " "
    end
    puts "----------"
    puts "Incorrect Questions"
    @incorrect_questions.each do |question|
      puts question_prompt(question)
      puts " "
    end
  end

  def display_question(current_question, question_idx)
    prompt = ((question_idx + 1).to_s + question_prompt(current_question))
    ask(prompt, answer_type = String) do |q|
        q.limit = 1
        q.in = Letters[0,current_question.choices.count]
        q.case = :up
      end
  end

  def question_prompt(current_question)
    output = " " + current_question.question.to_s + "\n"
    current_question.choices.each_with_index do |choice, choice_idx|
      output += Letters[choice_idx].to_s + ". "+ choice.to_s + "\n"
    end
    output
  end

  def evaluate_answer(current_question, guess)
    puts " "
    if Letters.index(guess) == current_question.answer
      puts "You got the question right"
      @correct_questions.push(current_question)
    else
      puts "You got the question wrong. The answer was #{Letters[current_question.answer]}"
      @incorrect_questions.push(current_question)
    end
  end
end