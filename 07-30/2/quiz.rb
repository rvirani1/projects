require 'pry'

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
    },
    {question: "Why?", choices: ["to learn", "why not"], answer: 0},
    {question: "How?", choices: ["with help", "why not"], answer: 0},
    {question: "Where?", choices: ["ATV", "NYC"], answer: 0}
]

Letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]

class QuizGame
  def initialize(questions)
    @questions = questions.shuffle
    @correct_questions = []
    @incorrect_questions = []
  end

  def play
    @questions.each_with_index do |current_question, question_idx|
      display_question(current_question, question_idx)
      evaluate_answer(current_question, gets.chomp!().capitalize)
      puts "Answered: #{question_idx + 1} Correct: #{@correct_questions.count} Incorrect: #{@incorrect_questions.count}"
    end
    puts " "
    puts "Correct Questions"
    @correct_questions.each do |question|
      display_question(question, @questions.index(question))
      puts " "
    end
    puts "----------"
    puts "Incorrect Questions"
    @correct_questions.each do |question|
      display_question(question, @questions.index(question))
      puts " "
    end

  end

  def display_question(current_question, question_idx)
    puts " "
    puts (question_idx + 1).to_s + " " + current_question[:question]
    current_question[:choices].each_with_index do |choice, choice_idx|
      puts Letters[choice_idx] + ". "+ choice
    end
  end

  def evaluate_answer(current_question, guess)
    puts " "
    if Letters.index(guess) == current_question[:answer]
      puts "You got the question right"
      @correct_questions.push(current_question)
    else
      puts "You got the question wrong. The answer was #{Letters[current_question[:answer]]}"
      @incorrect_questions.push(current_question)
    end
  end

end