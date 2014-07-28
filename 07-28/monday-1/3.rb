# Why doesn't Fixnum.new work?
# So usually when a class is instantiated, you actually create a new object for that class
# Fixnum is defined so that you don't modify members of the class. Each integer has a preexisting object and that object is just copied as it is. It's immutable, so you can't change the objects for the class once they are created. I'm not sure why this is better than creating a reference to an integer, but I'll have to read more about it.

