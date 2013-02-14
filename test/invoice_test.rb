require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'
 
class Invoice_Item_Test < MiniTest::Unit::TestCase
 
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  # def test_create_invoice
  #   invoice_item = InvoiceItem.new({"id" => 1, "item_id" => 2, "invoice_id" => 3, "quantity" => 4, "unit_price" => 5, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
  #   assert_equal 1, invoice_item.id
  #   assert_equal 2, invoice_item.item_id
  #   assert_equal 3, invoice_item.invoice_id
  #   assert_equal 4, invoice_item.quantity
  #   assert_equal 5, invoice_item.unit_price
  #   assert_equal Time.utc(2012, 3, 25, 9, 54, 9), invoice_item.created_at
  #   assert_equal Time.utc(2012, 3, 25, 9, 54, 9), invoice_item.updated_at 
  # end
 
end