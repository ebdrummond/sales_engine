require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest <MiniTest::Unit::TestCase

  def test_create_item
    item = Item.new({"id" => 1, "name" => 2, "description" => 3, "unit_price" => 4, "merchant_id" => 5, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, item.id
    assert_equal 2, item.name
    assert_equal 3, item.description
    assert_equal 4, item.unit_price
    assert_equal 5, item.merchant_id
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), item.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), item.updated_at 
  end

end