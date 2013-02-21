require './test/test_helper'

module SalesEngine
  class MerchantTest <MiniTest::Unit::TestCase

    def setup
      merchants_file = CSV.open("./data/merchants.csv", headers: true)
      merchants = []

      merchants_file.each do |row|
        merchants << Merchant.new(row)
      end
      Merchant.store(merchants)
    end

  # ********************** Find By **********************

    def test_find_by_id
      merchant = Merchant.find_by_id(6)
      assert_equal 6, merchant.id
    end

    def test_find_by_name
      merchant = Merchant.find_by_name("sCHroeder-jerDe")
      assert_equal "Schroeder-Jerde", merchant.name
    end

    def test_find_by_created_at
      date = "2012-03-27"
      merchant = Merchant.find_by_created_at(date)
      assert_equal "2012-03-27", merchant.created_at
    end

    def test_find_by_updated_at
      date = Date.parse("2012-03-27")
      merchant = Merchant.find_by_updated_at(date)
      assert_equal Date.parse("2012-03-27"), merchant.updated_at
    end

  # ********************** Find All By **********************

    def test_find_all_by_id
      merchant = Merchant.find_all_by_id(6)
      assert_equal 1, merchant.count
    end

    def test_find_all_by_name
      merchant = Merchant.find_all_by_name("schroeder-Jerde")
      assert_equal 1, merchant.count
    end

    def test_find_all_by_created_at
      date = "2012-03-27"
      merchant = Merchant.find_all_by_created_at(date)
      assert_equal 100,merchant.count
    end

    def test_find_all_by_upload_at
      date = Date.parse("2012-03-27")
      merchant = Merchant.find_all_by_updated_at(date)
      assert_equal 100,merchant.count
    end

    def test_finds_merchant_items
      items_file = CSV.open("./data/items.csv", headers: true)
      items = []

      items_file.each do |row|
        items << Item.new(row)
      end
      Item.store(items)

      merchant = Merchant.find_by_id(1)
      Item.find_all_by_merchant_id(1)
      assert_equal 15, merchant.items.count
    end

    def test_finds_merchant_invoices
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
        invoices <<Invoice.new(row)
      end
      Invoice.store(invoices)

      merchant = Merchant.find_by_id(29)
      Invoice.find_all_by_merchant_id(29)
      assert_equal 49, merchant.invoices.count
    end
  end
end
