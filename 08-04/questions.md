Please add a picture to your Github user account.

### 0. Code review

1.
  * Review some code

2.
  * Use `gem which [gemname]` to find the source code for
    a gem you use (`highline`, `minitest` or `colorize` are
    good candidates here), and look over the source. Do you
    get a general sense of how it works? (Don't forget: you
    can drop a `binding.pry` in here just as well as in your
    code!)

### 1. Class Questions

Update (/ rewrite) your quiz script to

1.
  * Define a Question class
  * Use Question objects in place of the hashes used
    earlier

2.
  * Be more flexible about user input (can use a or 1)
  * Validate and handle bad user input

### 2. Blackjack

1.
  * Add a Person class, with Player and Dealer subclasses
  * Make Hand and Deck Enumerable. What functionality
      does that add?

2.
  * Write tests for Player and Dealer

3.
  * Encapsulate the entire game in an object and test
    it. You may want to allow the game to specify an
    IO stream to be able to test it. See:
    http://ruby-doc.org/stdlib-2.1.2/libdoc/stringio/rdoc/StringIO.html.
