require './test/test_helper'

module SalesEngine
  class CustomerTest <MiniTest::Unit::TestCase

    def setup
      customers_file = CSV.open("./data/customers.csv", headers: true)
      customers = []

      customers_file.each do |row|
        customers << Customer.new(row)
      end
      Customer.store(customers)
    end

    def test_create_customer
      customer = Customer.new({"id" => 1, "first_name" => 2, "last_name" => 3})
      assert_equal 1, customer.id
      assert_equal 2, customer.first_name
      assert_equal 3, customer.last_name
    end

    def test_finds_a_customer_by_id
      customer = Customer.find_by_id(6)
      assert_equal 6, customer.id
    end

    def test_finds_a_customer_by_first_name
      customer = Customer.find_by_first_name("sylvester")
      assert_equal "Sylvester", customer.first_name
    end

    def test_finds_a_customer_by_last_name
      customer = Customer.find_by_last_name("FADEL")
      assert_equal "Fadel", customer.last_name
    end

    def test_finds_a_customer_by_created_at
      date = Date.parse("2012-03-27")
      customer = Customer.find_by_created_at(date)
      assert_equal Date.parse("2012-03-27"), customer.created_at
    end

    def test_finds_a_customer_by_updated_at
      date = Date.parse("2012-03-27")
      customer = Customer.find_by_updated_at(date)
      assert_equal Date.parse("2012-03-27"), customer.updated_at
    end

    def test_finds_all_customers_by_id
      customer = Customer.find_all_by_id(29)
      assert_equal 1, customer.count
    end

    def test_finds_all_customers_by_first_name
      customer = Customer.find_all_by_first_name("BRent")
      assert_equal 2, customer.count
    end

    def test_finds_all_customers_by_last_name
      customer = Customer.find_all_by_last_name("brekke")
      assert_equal 6, customer.count
    end

    def test_finds_all_customers_by_created_at
      date = Date.parse("2012-03-27")
      customer = Customer.find_all_by_created_at(date)
      assert_equal 1000, customer.count
    end

    def test_finds_all_customers_by_updated_at
      date = Date.parse("2012-03-27")
      customer = Customer.find_all_by_updated_at(date)
      assert_equal 1000, customer.count
    end

      def test_finds_customer_invoices
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      customer = Customer.find_by_id(1)
      Invoice.find_all_by_customer_id(1)
      assert_equal 8, customer.invoices.count
    end

    def test_finds_merchants_associated_with_each_customer
      merchants_file = CSV.open("./data/merchants.csv", headers: true)
      merchants = []

      merchants_file.each do |row|
      merchants << Merchant.new(row)
      end
      Merchant.store(merchants)

      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions= []

      transactions_file.each do |row|
        transactions<< Transaction.new(row)
      end
      Transaction.store(transactions)

      customer = Customer.find_by_id(29)
      customer.merchants_per_customer
      assert_equal 7, customer.merchants_per_customer.count
    end

    def test_finds_sorted_merchants_associated_with_each_customer
      merchants_file = CSV.open("./data/merchants.csv", headers: true)
      merchants = []

      merchants_file.each do |row|
      merchants << Merchant.new(row)
      end
      Merchant.store(merchants)

      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions= []

      transactions_file.each do |row|
        transactions<< Transaction.new(row)
      end
      Transaction.store(transactions)

      customer = Customer.find_by_id(29)
      customer.sorted_merchants_per_customer
      assert_equal 7, customer.sorted_merchants_per_customer.count
    end

    def test_finds_favorite_merchant
      merchants_file = CSV.open("./data/merchants.csv", headers: true)
      merchants = []

      merchants_file.each do |row|
      merchants << Merchant.new(row)
      end
      Merchant.store(merchants)

      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions= []

      transactions_file.each do |row|
        transactions<< Transaction.new(row)
      end
      Transaction.store(transactions)

      customer = Customer.find_by_id(29)
      customer.favorite_merchant
      assert_equal "Huels, Homenick and Smith", customer.favorite_merchant.name
    end

    def test_finds_customer_transactions
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
      invoices << Invoice.new(row)
      end
      Invoice.store(invoices)

      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions= []

      transactions_file.each do |row|
        transactions<< Transaction.new(row)
      end
      Transaction.store(transactions)

      customer = Customer.find_by_id(29)
      customer.transactions
      assert_equal 7, customer.transactions.count
    end
  end
end
