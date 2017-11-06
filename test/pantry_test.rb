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

end
