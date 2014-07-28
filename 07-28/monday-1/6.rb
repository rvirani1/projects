# Define an Averager class that can compute the average of two numbers. Bonus: any number of numbers.

class Averager
  def average(numArray)
    count = numArray.count
    total = numArray.pop()
    numArray.each do |num|
      total += num
    end
    total / count
  end
end