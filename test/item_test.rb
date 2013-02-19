require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest <MiniTest::Unit::TestCase

    def setup
        items_file = CSV.open("./data/items.csv", headers: true)
        items = []

        items_file.each do |row|
          items << Item.new(row)
      end
      Item.store(items)
  end

  def test_create_item
    item = Item.new({"id" => 1, "name" => 2, "description" => 3, "unit_price" => 4, "merchant_id" => 5, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, item.id
    assert_equal 2, item.name
    assert_equal 3, item.description
    assert_equal 4, item.unit_price
    assert_equal 5, item.merchant_id
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, item.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, item.updated_at 
  end

  def test_finds_an_item_by_id
    item = Item.find_by_id(1)
    assert_equal 1, item.id
    end

    def test_finds_an_item_by_name
        item = Item.find_by_name("item qui esse")
        assert_equal "Item Qui Esse", item.name
    end

    def test_finds_an_item_by_description
        item = Item.find_by_description("nihil AUtem sit odio invEntore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
        assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item.description
    end

    def test_finds_an_item_by_unit_price
        item = Item.find_by_unit_price(75107)
        assert_equal 75107, item.unit_price
    end

    def test_finds_an_item_by_merchant_id
        item = Item.find_by_merchant_id(1)
        assert_equal 1, item.merchant_id
    end

    def test_finds_an_item_by_created_at
        item = Item.find_by_created_at("2012-03-27 14:53:59 utc")
        assert_equal "2012-03-27 14:53:59 UTC", item.created_at
    end

    def test_finds_an_item_by_updated_at
        item = Item.find_by_updated_at("2012-03-27 14:53:59 UTC")
        assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
    end

    def test_finds_all_items_by_id
        item = Item.find_all_by_id(8)
        assert_equal 1, item.count
    end

    def test_finds_all_items_by_name
        item = Item.find_all_by_name("Item Est Consequuntur")
        assert_equal 1, item.count
    end

    def test_finds_all_items_by_description
        item = Item.find_all_by_description("Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.")
        assert_equal 1, item.count
    end

    def test_finds_all_items_by_unit_price
        item = Item.find_all_by_unit_price(22582)
        assert_equal 1, item.count
    end

    def test_finds_all_items_by_merchant_id
        item = Item.find_all_by_merchant_id(1)
        assert_equal 15, item.count
    end

    def test_finds_all_by_created_at
        item = Item.find_all_by_created_at("2012-03-27 14:53:59 UTC")
        assert_equal 170, item.count
    end

    def test_finds_all_by_updated_at
        item = Item.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
        assert_equal 170, item.count
    end

    def test_finds_item_invoice_items
    invoice_items_file = CSV.open("../data/test_invoice_items.csv", headers: true)
    invoice_items = []

    invoice_items_file.each do |row|
    invoice_items << InvoiceItem.new(row)
    end
    InvoiceItem.store(invoice_items)

    item = Item.find_by_id(1)
    InvoiceItem.find_all_by_item_id(1)
    assert_equal 1, item.invoice_items.count
    end
    
    def test_finds_item_merchants
    items_file = CSV.open("../data/test_items.csv", headers: true)
    items = []

    items_file.each do |row|
    items << Item.new(row)
    end
    Item.store(items)

    item = Item.find_by_merchant_id(1)
    Merchant.find_by_id(1)
    assert_equal 1,item.merchant.count
    end

end
