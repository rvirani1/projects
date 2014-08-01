require 'minitest/autorun'
require './survey.rb'
require './statements.rb'


describe "Survey" do
  it "has no ratings or calculated values when it starts" do
    s = Survey.new(Statements)
    assert_equal s.ratings, []
    assert_equal s.highest, nil
    assert_equal s.lowest, nil
    assert_equal s.average, nil
  end

  it "lets users enter a ratings and stores it" do
    s = Survey.new(Statements)
    s.store_rating(3)
    assert s.ratings.include?(3)
  end

  it "calculates the highest rating" do
    s = Survey.new(Statements)
    s.store_rating(1)
    s.store_rating(2)
    s.calculate_results
    assert_equal s.highest, 2
  end
  it "calculates the lowest rating" do
    s = Survey.new(Statements)
    s.store_rating(1)
    s.store_rating(2)
    s.calculate_results
    assert_equal s.lowest, 1
  end
  it "calculates the average rating" do
    s = Survey.new(Statements)
    s.store_rating(1)
    s.store_rating(3)
    s.calculate_results
    assert_equal s.average, 2
  end
end