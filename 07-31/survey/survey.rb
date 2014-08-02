require 'pry'
=begin
### 1. Survey

Write a questionnaire that takes a list of statements,
and asks the user to rate how strongly they agree with
the statement (on a scale of 1 to 5).

    Level 1:
    After the survey is over, print out the user's highest,
  lowest, and average rating.

Level 2:
  Write a Survey class and have an external script to
  drive the user interaction.

Level 3:
  Write tests for your Survey class.
=end

class Survey
  attr_reader :statements, :ratings, :highest, :lowest, :average
  def initialize(statements)
    @statements = statements
    @ratings = []
  end

  def store_rating(input)
    @ratings.push(input)
  end

  def print_statement(statement)
    puts ""
    puts "Please rate the following statement from 1-5"
    puts statement
  end

  def calculate_results
    @highest = @ratings.first
    @lowest = @ratings.first
    sum = 0.0
    @ratings.each do |rating|
      sum += rating
      @highest = rating if rating > @highest
      @lowest = rating if rating < @lowest
    end
    @average = sum / @ratings.count
  end

  def print_results
    calculate_results
    puts "The highest rating was #{@ratings.max}"
    puts "The lowest rating was #{@lowest}"
    puts "The average rating was #{@average}"
  end
end