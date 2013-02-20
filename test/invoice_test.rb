require 'simplecov'
SimpleCov.start
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoicesTest <MiniTest::Unit::TestCase

  def setup
    invoices_file = CSV.open("./data/invoices.csv", headers: true)
    invoices = []

    invoices_file.each do |row|
      invoices << Invoice.new(row)
    end
    Invoice.store(invoices)
  end

  def test_create_invoice
    invoice = Invoice.new({"id" => 1, "merchant_id" => 2, "customer_id" => 3, "status" => 4})
    assert_equal 1, invoice.id
    assert_equal 2, invoice.merchant_id
    assert_equal 3, invoice.customer_id
    assert_equal 4, invoice.status
  end

  def test_finds_an_invoice_by_id
    invoice = Invoice.find_by_id(1)
    assert_equal 1, invoice.id
  end

  def test_finds_an_invoice_by_customer_id
    invoice = Invoice.find_by_customer_id(1)
    assert_equal 1, invoice.customer_id
  end

  def test_finds_an_invoice_by_merchant_id
    invoice = Invoice.find_by_merchant_id(26)
    assert_equal 26, invoice.merchant_id
  end

  def test_finds_an_invoice_by_status
    invoice = Invoice.find_by_status("SHipped")
    assert_equal "shipped", invoice.status
  end

  def test_finds_an_invoice_by_created_at
    invoice = Invoice.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_finds_an_invoice_by_updated_at
    invoice = Invoice.find_by_updated_at("2012-03-25 09:54:09 utc")
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_finds_all_invoices_by_id
    invoice = Invoice.find_all_by_id(8)
    assert_equal 1, invoice.count
  end

  def test_finds_all_invoices_by_customer_id
    invoice = Invoice.find_all_by_customer_id(1)
    assert_equal 8, invoice.count
  end

  def test_finds_all_invoices_by_merchant_id
    invoice = Invoice.find_all_by_merchant_id(27)
    assert_equal 48, invoice.count
  end

  def test_finds_all_invoices_by_status
    invoice = Invoice.find_all_by_status("Shipped")
    assert_equal 4843, invoice.count
  end

  def test_finds_all_invoices_by_created_at
    invoice = Invoice.find_all_by_created_at("2012-03-12 05:54:09 UTC")
    assert_equal 1, invoice.count
  end

  def test_finds_all_invoices_by_updated_at
    invoice = Invoice.find_all_by_updated_at("2012-03-07 04:54:20 UTC")
    assert_equal 1, invoice.count
  end

  def test_finds_invoice_transactions
  transactions_file = CSV.open("./data/transactions.csv", headers: true)
    transactions = []

    transactions_file.each do |row|
      transactions << Transaction.new(row)
    end
    Transaction.store(transactions)

    invoice = Invoice.find_by_id(1)
    invoice.transactions
    assert_equal 1, invoice.transactions.count
  end

  def test_finds_invoice_invoice_items
    invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

    invoice_items_file.each do |row|
        invoice_items << InvoiceItem.new(row)
    end
    InvoiceItem.store(invoice_items)

    invoice = Invoice.find_by_id(1)
    invoice.invoice_items
    assert_equal 8, invoice.invoice_items.count
  end

  def test_finds_invoice_items    
    invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

    invoice_items_file.each do |row|
        invoice_items << InvoiceItem.new(row)
    end
    InvoiceItem.store(invoice_items)

    items_file = CSV.open("./data/items.csv", headers: true)
      items = []

    items_file.each do |row|
        items << Item.new(row)
    end
    Item.store(items)

    invoice = Invoice.find_by_id(1)
    invoice.items
    assert_equal 8, invoice.items.count
  end

  def test_finds_customer_instance
    customers_file = CSV.open("./data/customers.csv", headers: true)
      customers = []

    customers_file.each do |row|
      customers << Customer.new(row)
    end
    Customer.store(customers)

    invoice = Invoice.find_by_customer_id(2)
    invoice.customer
    assert_equal "Osinski", invoice.customer.last_name
  end

  def test_creating_an_invoice_makes_an_invoice
    starting_count = Invoice.count
    Invoice.create 
    assert_equal starting_count +1, Invoice.count
  end

  class MockCustomer
    def id
      100000
    end
   end

   class MockMerchant
    def id
      999999
    end
  end

  class MockItem
    attr_reader :id
    def initialize(input)
      @id = input
    end
  end

  def test_creating_an_invoice_associates_with_a_customer
    customer = MockCustomer.new
    merchant = MockMerchant.new
    invoice = Invoice.create({:customer => customer, :merchant => merchant})
    assert_equal customer.id, invoice.customer_id
  end

  def test_creating_an_invoice_associates_with_a_merchant
    merchant = MockMerchant.new
    customer = MockCustomer.new
    invoice = Invoice.create({:merchant => merchant, :customer => customer})
    assert_equal merchant.id, invoice.merchant_id
  end

  def test_creating_an_invoice_associates_with_items
    item1 = MockItem.new(88888)
    item2 = MockItem.new(77777)
    item3 = MockItem.new(66666)
    merchant = MockMerchant.new
    customer = MockCustomer.new
    invoice = Invoice.create({:merchant => merchant, :customer => customer, :items => [item1, item2, item3]})
    assert_includes invoice.items, item1
    assert_includes invoice.items, item2
    assert_includes invoice.items, item3
  end

  def test_generates_new_invoice_id
    id = Invoice.generate_id
    refute Invoice.find_by_id(id), "found a matching invoice id"
  end

  def test_returns_only_invoices_with_valid_transactions
    transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions = []

    transactions_file.each do |row|
      transactions << Transaction.new(row)
    end
    Transaction.store(transactions)

    invoice = Invoice.find_by_id(29)
    invoice.valid_transaction
    assert_equal 1, invoice.valid_transaction.count
  end



end
