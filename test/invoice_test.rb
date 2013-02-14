require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoicesTest <MiniTest::Unit::TestCase

  def test_create_invoice
    invoice = Invoice.new({"id" => 1, "merchant_id" => 2, "customer_id" => 3, "status" => 4, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, invoice.id
    assert_equal 2, invoice.merchant_id
    assert_equal 3, invoice.customer_id
    assert_equal 4, invoice.status
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), invoice.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9), invoice.updated_at 
  end

end
