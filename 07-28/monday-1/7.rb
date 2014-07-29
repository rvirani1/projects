# Write a script to read list of lines from a file and print one at random

require "pry"

file_to_read = ARGV.first
lines = IO::readlines(file_to_read)

binding.pry

puts IO::readlines(ARGV.first).sample()