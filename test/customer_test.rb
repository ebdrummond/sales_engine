require 'simplecov'
SimpleCov.start
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

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
    customer = Customer.new({"id" => 1, "first_name" => 2, "last_name" => 3, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, customer.id
    assert_equal 2, customer.first_name
    assert_equal 3, customer.last_name
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, customer.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, customer.updated_at
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
    customer = Customer.find_by_created_at("2012-03-27 14:54:09 utc")
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_finds_a_customer_by_updated_at
    customer = Customer.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
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
    customer = Customer.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 6, customer.count
  end

  def test_finds_all_customers_by_updated_at
    customer = Customer.find_all_by_updated_at("2012-03-27 14:54:11 UTC")
    assert_equal 3, customer.count
  end

    def test_finds_customer_invoices
    invoices_file = CSV.open("./data/test_invoices.csv", headers: true)
    invoices = []

    invoices_file.each do |row|
    invoices << Invoice.new(row)
    end
    Invoice.store(invoices)

    customer = Customer.find_by_id(1)
    Invoice.find_all_by_customer_id(1)
    assert_equal 8, customer.invoices.count
  end
end
