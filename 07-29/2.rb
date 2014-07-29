=begin
2.
    * Write a method `grade` that takes in a numerical grade 1-100 and
    prints out the letter version of it.
    * Write a function that produces an array of random scores: `students(5) = [88, 93, 91, 73, 97]`
    * Compute the grades for a class of 25 students. Write a function to
determine how many A's there were.
=end

require 'pry'

def grade(num)
  # TODO print out letter grade
  case num
    when 0..70
      puts "F"
      return "F"
    when 70..80
      puts "C"
      return "C"
    when 80..90
      puts "B"
      return "B"
    when 90..100
      puts "A"
      return "A"
    else
      puts "Didn't match anything"
  end
end

def students(count)
  finalArray = []
  count.times do
    finalArray << Random.rand(100)
  end
  finalArray
end

def classGrades(gradesArray)
  totalAs = 0
  gradesArray.each do |f|
    totalAs += 1 if (grade(f) == "A")
  end
  totalAs
end