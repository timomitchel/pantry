require './lib/pantry'
require "./lib/recipe"
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_pantry_attributes
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_stock_check
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check('Cheese')
  end

  def test_restock_changes_stock_check
    pantry = Pantry.new


    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check('Cheese')
  end

  def test_restock_adds_to_cheese
    pantry = Pantry.new

    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check('Cheese')
  end

  def test_add_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')

    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(r)
    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list
  end

  def test_another_recipe_adds_to_shopping_list_correctly
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')

    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(r)

    r_1 = Recipe.new("Spaghetti")
    r_1.add_ingredient("Spaghetti Noodles", 10)
    r_1.add_ingredient("Marinara Sauce", 10)
    r_1.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r_1)
    expected = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}

    assert_equal expected, pantry.shopping_list
  end

  def test_print_shopping_list
    pantry = Pantry.new
    r = Recipe.new('Cheese Pizza')

    r.add_ingredient('Cheese', 20)
    r.add_ingredient('Flour', 20)
    pantry.add_to_shopping_list(r)

    r_1 = Recipe.new("Spaghetti")
    r_1.add_ingredient("Spaghetti Noodles", 10)
    r_1.add_ingredient("Marinara Sauce", 10)
    r_1.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r_1)

    assert_equal "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10", pantry.print_shopping_list
  end

  def test_cookbook_holds_recipe_objects
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_instance_of Array, pantry.cookbook
    assert_equal 3, pantry.cookbook.length
  end

end
