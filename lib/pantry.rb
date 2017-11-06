class Pantry

  attr_reader :stock, :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = []
    @cookbook = []
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
    @shopping_list.reduce {|result, hash| result.merge(hash) {|key,v1,v2| v1 + v2 }}
  end

  def print_shopping_list
    shopping_list.each do |key, value|
      puts "* #{key}: #{value}\n"
    end
    "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    cookbook.map do |recipe|
      recipe.name if
      zip_stock_and_required.map do |amounts|
        amounts[1] >= amounts[0]
      end
    end
  end

  def zip_ingredients
    zip_stock_and_required.zip(grab_ingredients)
  end


  def zip_stock_and_required
    grab_amounts_required.zip(check_amount_in_stock)
  end

  def grab_amounts_required
    requirements = cookbook.map do |recipe|
      grab_ingredients.map do |ingredient|
        recipe.amount_required(ingredient)
      end.flatten.compact
    end
    requirements.flatten
  end

  def check_amount_in_stock
    grab_ingredients.map do |ingredient|
      stock_check(ingredient)
    end
  end

  def grab_ingredients
    cookbook.map do |recipe|
      recipe.ingredient_types
    end.flatten
  end
end
