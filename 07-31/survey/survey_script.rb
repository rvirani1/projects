require './survey.rb'
require './statements.rb'

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

s = Survey.new(Statements)
s.statements.each do |statement|
  s.print_statement(statement)
  s.store_rating(gets.chomp.to_i)
end
s.calculate_results
s.print_results



