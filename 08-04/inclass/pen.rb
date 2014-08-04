require 'colorize'

class Pen
  attr_reader :color

  def initialize color
    @color = color
  end

  def write text
    puts text.send(color)
  end
end

class ClickyPen < Pen
  def color= new_color
    @color = new_color
  end
end