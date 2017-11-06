class Pantry

  attr_reader :stock

  def initialize
    @stock = Hash.new(0)
    @shopping_list = []
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def restock(ingredient, amount)
    @stock[ingredient] += amount
  end

  def add_to_shopping_list(stuff)
     @shopping_list << stuff.ingredients
  end

  def shopping_list
    @shopping_list.reduce(Hash.new) do |result, hash|
      result.merge(hash)
    end
  end
end
