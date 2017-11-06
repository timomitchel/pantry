class Pantry

  attr_reader :stock, :shopping_list

  def initialize
    @stock = Hash.new(0)
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def restock(ingredient, amount)
    @stock[ingredient] += amount
  end

  def add_to_shopping_list(stuff)
    @shopping_list = stuff.ingredients
  end
end
