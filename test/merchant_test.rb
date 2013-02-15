require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/item'

class MerchantTest <MiniTest::Unit::TestCase

  def setup
    merchants_file = CSV.open("./data/test_merchants.csv", headers: true)
    merchants = []

    merchants_file.each do |row|
      merchants << Merchant.new(row)
    end
    Merchant.store(merchants)
  end

  # def setup2
  #   items_file = CSV.open("../data/test_items.csv", headers: true)
  #   items = []

  #   items_file.each do |row|
  #     items << Item.new(row)
  #   end
  #   Item.store(items)
  # end

  def test_create_merchant
    merchant = Merchant.new({"id" => 1, "name" => 2, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, merchant.id
    assert_equal 2, merchant.name
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, merchant.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, merchant.updated_at 
  end

# ********************** Find By **********************

  def test_find_by_id
    merchant = Merchant.find_by_id(6)
    assert_equal 6, merchant.id
  end

  def test_find_by_name
    merchant = Merchant.find_by_name("Schroeder-Jerde")
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_find_by_created_at
    merchant = Merchant.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_find_by_updated_at
    merchant = Merchant.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

# ********************** Find All By **********************

  def test_find_all_by_id
    merchant = Merchant.find_all_by_id(6)
    assert_equal 1, merchant.count
  end

  def test_find_all_by_name
    merchant = Merchant.find_all_by_name("Schroeder-Jerde")
    assert_equal 1, merchant.count
  end

  def test_find_all_by_created_at
    merchant = Merchant.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 9,merchant.count
  end

  def test_find_all_by_upload_at
    merchant = Merchant.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 8,merchant.count
  end

  def test_find_merchant_items
    merchant_items = 
    merchant.find_merchant_items(1)
    assert_equal 1, merchant.id
  end
  
end
