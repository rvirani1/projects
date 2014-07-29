=begin
4. Write a shopping cart class that stores any number of items
* Users should be able to add and remove items from the cart
* The cart should be able to compute the total checkout price, after applying tax
* Shoppers get a 10% discount if they spend more than $100 (before tax)
=end
require 'pry'

class ShoppingCart
  attr_accessor(:taxRate)

  def initialize(taxRate)
    @taxRate = taxRate
    @items = []
  end

  def addItem(item)
    @items << item
  end

  def removeItem(item)
    @items.delete(item) if @items.include?(item)
  end

  def checkout
    subtotal() + taxAmount() - discountAmount()
  end

  def taxAmount
    subtotal() * @taxRate
  end

  def discountAmount
    if (subtotal() >= 100)
      subtotal() * 0.1
    else
      0
    end
  end

  def subtotal
    total = 0
    @items.each do |f|
      total += f.price
    end
    total
  end

end

class Item
  attr_reader(:price)
  def initialize(name, price)
    @name = name
    @price = price
  end
end
