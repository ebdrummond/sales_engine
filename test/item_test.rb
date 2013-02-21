require './test/test_helper'

module SalesEngine
    class ItemTest <MiniTest::Unit::TestCase

        def setup
            items_file = CSV.open("./data/items.csv", headers: true)
            items = []

            items_file.each do |row|
              items << Item.new(row)
          end
          Item.store(items)
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
            item = Item.find_by_unit_price(BigDecimal.new(75107 / 100.0, 12))
            assert_equal (BigDecimal.new(75107 / 100.0, 12)), item.unit_price
        end

        def test_finds_an_item_by_merchant_id
            item = Item.find_by_merchant_id(1)
            assert_equal 1, item.merchant_id
        end

        def test_finds_an_item_by_created_at
            item = Item.find_by_created_at(Date.parse("2012-03-27"))
            assert_equal (Date.parse("2012-03-27")), item.created_at
        end

        def test_finds_an_item_by_updated_at
            item = Item.find_by_updated_at(Date.parse("2012-03-27"))
            assert_equal Date.parse("2012-03-27"), item.updated_at
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
            item = Item.find_all_by_unit_price(BigDecimal.new(22582 / 100.0, 12))
            assert_equal 1, item.count
        end

        def test_finds_all_items_by_merchant_id
            item = Item.find_all_by_merchant_id(1)
            assert_equal 15, item.count
        end

        def test_finds_all_by_created_at
            item = Item.find_all_by_created_at(Date.parse("2012-03-27"))
            assert_equal 2483, item.count
        end

        def test_finds_all_by_updated_at
            item = Item.find_all_by_updated_at(Date.parse("2012-03-27"))
            assert_equal 2483, item.count
        end

        def test_finds_item_invoice_items
        invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
        invoice_items = []

        invoice_items_file.each do |row|
        invoice_items << InvoiceItem.new(row)
        end
        InvoiceItem.store(invoice_items)

        item = Item.find_by_id(13)
        InvoiceItem.find_all_by_item_id(13)
        assert_equal 19, item.invoice_items.count
        end
        
        def test_finds_item_merchant
        merchants_file = CSV.open("./data/merchants.csv", headers: true)
        merchants = []

        merchants_file.each do |row|
        merchants << Merchant.new(row)
        end
        Merchant.store(merchants)

        item = Item.find_by_id(29)
        item.merchant
        assert_equal "Klein, Rempel and Jones", item.merchant.name
        end

        def test_finds_total_items_sold
            invoices_file = CSV.open("./data/invoices.csv", headers: true)
            invoices = []

            invoices_file.each do |row|
            invoices << Invoice.new(row)
            end
            Invoice.store(invoices)

            item = Item.find_by_id(66)
            item.total_sold
            assert_equal 16, item.total_sold
        end

    end
end
