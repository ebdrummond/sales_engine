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

    def test_finds_merchant_revenue_for_all_dates
      invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

      invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
      end
      InvoiceItem.store(invoice_items)

      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      merchant = Merchant.find_by_id(29)
      merchant.revenue
      assert_equal (BigDecimal.new(59881657 / 100.0, 12)), merchant.revenue
    end

    # def test_finds_most_revenue
    #   invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
    #   invoice_items = []

    #   invoice_items_file.each do |row|
    #   invoice_items << InvoiceItem.new(row)
    #   end
    #   InvoiceItem.store(invoice_items)

    #   invoices_file = CSV.open("./data/invoices.csv", headers: true)
    #   invoices = []

    #   invoices_file.each do |row|
    #   invoices << Invoice.new(row)
    #   end
    #   Invoice.store(invoices)

    #   merchant = Merchant.collection
    #   merchants = merchant.most_revenue(5)
    #   assert_equal ("Dicki-Bednar"), merchants[0].name
    # end

    def test_if_merchant_finds_item_count
      invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

      invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
      end
      InvoiceItem.store(invoice_items)

      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      items_file = CSV.open("./data/items.csv", headers: true)
      items = []

      items_file.each do |row|
        items << Item.new(row)
      end
      Item.store(items)

      merchant = Merchant.find_by_id(28)
      merchant.item_count
      assert_equal 1021, merchant.item_count
    end

    def test_invoices_paid_count
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      merchant = Merchant.find_by_id(27)
      merchant.paid_invoices
      assert_equal 46, merchant.paid_invoices.count
    end

    def test_pending_invoices
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions = []

      transactions_file.each do |row|
        transactions << Transaction.new(row)
      end
      Transaction.store(transactions)

      merchant = Merchant.find_by_id(88)
      merchant.pending_invoices
      assert_equal 3,merchant.pending_invoices.count
    end

    def test_finds_customers_with_pending_invoices
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions = []

      transactions_file.each do |row|
        transactions << Transaction.new(row)
      end
      Transaction.store(transactions)

      customers_file = CSV.open("./data/customers.csv", headers: true)
      customers = []

      customers_file.each do |row|
      customers << Customer.new(row)
      end
      Customer.store(customers)

      merchant = Merchant.find_by_id(85)
      merchant.customers_with_pending_invoices
      assert_equal 2, merchant.customers_with_pending_invoices.count
    end

    def test_finds_favorite_customer
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions = []

      transactions_file.each do |row|
        transactions << Transaction.new(row)
      end
      Transaction.store(transactions)

      customers_file = CSV.open("./data/customers.csv", headers: true)
      customers = []

      customers_file.each do |row|
      customers << Customer.new(row)
      end
      Customer.store(customers)

      invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

      invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
      end
      InvoiceItem.store(invoice_items)

      merchant = Merchant.find_by_id(92)
      merchant.favorite_customer
      assert_equal 586, merchant.favorite_customer.id
    end

    def test_finds_customers_associated_with_a_specific_merchant
       invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions = []

      transactions_file.each do |row|
        transactions << Transaction.new(row)
      end
      Transaction.store(transactions)

      customers_file = CSV.open("./data/customers.csv", headers: true)
      customers = []

      customers_file.each do |row|
      customers << Customer.new(row)
      end
      Customer.store(customers)

      invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

      invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
      end
      InvoiceItem.store(invoice_items)

      merchant = Merchant.find_by_id(81)
      merchant.customers_per_merchant
      assert_equal 53, merchant.customers_per_merchant.count
    end

  end
end
