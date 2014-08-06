require 'yaml'
require "./Widget.rb"
require 'pry'

widgets = WidgetGroup.new(YAML.load_file("widgets.yml"))

revenue = widgets.map{|x| x.price * x.sold}.reduce(:+).round(2)
costs = widgets.map{|x| x.cost_to_make * x.sold}.reduce(:+).round(2)
profit = (revenue - costs).round(2)
grouped_by_department = widgets.group_by { |widget| widget.department }


puts "The most expensive widget is the #{widgets.max_by { |x| x.price }}"
puts ""
puts "The least expensive widget is the #{widgets.min_by { |x| x.price }}"
puts ""
puts "The total revenue is $#{revenue}"
puts ""
puts "The total profit is $#{profit}"
puts ""
puts "The top 10 selling widgets are:"
sorted_by_sales = widgets.sort_by{|widget| widget.sold}.reverse.first(10)
sorted_by_sales.each_with_index do |widget, index|
  puts "#{index + 1}. #{widget}"
end
puts ""
puts "The number of widgets sold by department:"
grouped_by_department.each do |department, widgets|
  puts "#{department}: #{widgets.reduce(0) {|sum, widget| sum + widget.sold}}"
end