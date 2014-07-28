# Write a script to read list of lines from a file and print one at random

lineArray = IO::readlines(ARGV.first)
puts lineArray.sample()