require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest <MiniTest::Unit::TestCase

  def test_create_merchant
    merchant = Merchant.new({"id" => 1, "name" => 2, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, merchant.id
    assert_equal 2, merchant.name
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), merchant.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), merchant.updated_at 
  end

end
