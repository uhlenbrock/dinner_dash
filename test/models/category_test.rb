require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "Creating a category requires a title" do
    category = Category.new
    assert ! category.valid?
    category.title = 'Test Title'
    assert category.valid?
  end
  
  test "Categories have many items" do
    item = items(:one)
    category = categories(:one)
    category.items << item
    assert category.items.include?(item)
  end
  
end
