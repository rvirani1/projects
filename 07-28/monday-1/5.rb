# Define Musher class such that Musher.new("+").mush(["array", "of", "strings"])  == "array + of + strings"

class Musher
  def initialize(fillIn)
    @fillIn = fillIn
  end

  def mush(arrayOfStrings)
    arrayOfStrings.join(" " + @fillIn + " ")
  end
end