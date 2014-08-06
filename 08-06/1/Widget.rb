require 'pry'


class WidgetGroup
  include Enumerable
  def initialize(yaml_input)
    @widgets = yaml_input.map { |widget_hash| Widget.new(widget_hash)}
  end

  def each
    @widgets.each { |widget| yield widget }
  end

  def to_s
    output = ""
    @widgets.each do |widget|
      output += widget.to_s + "\n"
    end
  end

end

class Widget
  attr_reader :name, :color, :department, :price, :cost_to_make, :sold

  def initialize(hash)
    @name = hash[:name]
    @color = hash[:color]
    @department = hash[:department]
    @price = hash[:price]
    @cost_to_make = hash[:cost_to_make]
    @sold = hash[:sold]
  end

  def to_s
    @name
  end

  def to_s_long
    "Name: #{@name}, Color: #{@color}, Department: #{@department}, Price: #{@price}, Cost To Make: #{@cost_to_make}, Sold: #{@sold}"
  end
end