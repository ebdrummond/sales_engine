require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoicesTest <MiniTest::Unit::TestCase

  def setup
    invoices_file = CSV.open("./data/test_invoices.csv", headers: true)
    invoices = []

    invoices_file.each do |row|
      invoices << Invoice.new(row)
    end
    Invoice.store(invoices)
  end

  def test_create_invoice
    invoice = Invoice.new({"id" => 1, "merchant_id" => 2, "customer_id" => 3, "status" => 4, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, invoice.id
    assert_equal 2, invoice.merchant_id
    assert_equal 3, invoice.customer_id
    assert_equal 4, invoice.status
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, invoice.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, invoice.updated_at 
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
    invoice = Invoice.find_by_status("shipped")
    assert_equal "shipped", invoice.status
  end

  def test_finds_an_invoice_by_created_at
    invoice = Invoice.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_finds_an_invoice_by_updated_at
    invoice = Invoice.find_by_updated_at("2012-03-25 09:54:09 UTC")
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_finds_all_invoices_by_id
    invoice = Invoice.find_all_by_id(8)
    assert_equal 2, invoice.count
  end

  def test_finds_all_invoices_by_customer_id
    invoice = Invoice.find_all_by_customer_id(1)
    assert_equal 8, invoice.count
  end

  def test_finds_all_invoices_by_merchant_id
    invoice = Invoice.find_all_by_merchant_id(27)
    assert_equal 2, invoice.count
  end

  def test_finds_all_invoices_by_status
    invoice = Invoice.find_all_by_status("shipped")
    assert_equal 9, invoice.count
  end

  def test_finds_all_invoices_by_created_at
    invoice = Invoice.find_all_by_created_at("2012-03-10 05:54:09 UTC")
    assert_equal 2, invoice.count
  end

  def test_finds_all_invoices_by_updated_at
    invoice = Invoice.find_all_by_updated_at("2012-03-10 05:54:09 UTC")
    assert_equal 2, invoice.count
  end
end
