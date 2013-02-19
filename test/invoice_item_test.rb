require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'
 
class Invoice_Item_Test < MiniTest::Unit::TestCase

  def setup
    invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
    invoice_items = []

    invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
    end
    InvoiceItem.store(invoice_items)
  end

  def test_create_invoice_item
    invoice_item = InvoiceItem.new({"id" => 1, "item_id" => 2, "invoice_id" => 3, "quantity" => 4, "unit_price" => 5, "created_at" => "2012-03-25 09:54:09 UTC", "updated_at" =>"2012-03-25 09:54:09 UTC"})
    assert_equal 1, invoice_item.id
    assert_equal 2, invoice_item.item_id
    assert_equal 3, invoice_item.invoice_id
    assert_equal 4, invoice_item.quantity
    assert_equal 5, invoice_item.unit_price
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, invoice_item.created_at
    assert_equal Time.utc(2012, 3, 25, 9, 54, 9).to_s, invoice_item.updated_at 
  end

  def test_finds_an_invoice_item_by_id
    invoice_item = InvoiceItem.find_by_id(6)
    assert_equal 6, invoice_item.id
  end

  def test_finds_an_invoice_item_by_item_id
    invoice_item = InvoiceItem.find_by_item_id(528)
    assert_equal 528, invoice_item.item_id
  end

  def test_finds_an_invoice_item_by_invoice_id
    invoice_item = InvoiceItem.find_by_invoice_id(1)
    assert_equal 1, invoice_item.invoice_id
  end

  def test_finds_an_invoice_item_by_quantity
    invoice_item = InvoiceItem.find_by_quantity(9)
    assert_equal 9, invoice_item.quantity
  end

  def test_finds_an_invoice_item_by_unit_price
    invoice_item = InvoiceItem.find_by_unit_price(13635)
    assert_equal 13635, invoice_item.unit_price
  end

  def test_finds_an_invoice_item_by_created_at
    invoice_item = InvoiceItem.find_by_created_at("2012-03-27 14:54:09 UTc")
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.created_at
  end

  def test_finds_an_invoice_item_by_updated_at
    invoice_item = InvoiceItem.find_by_updated_at("2012-03-27 14:54:09 utC")
    assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
  end

  def test_finds_all_invoice_items_by_id
    invoice_item = InvoiceItem.find_all_by_id(8)
    assert_equal 1, invoice_item.count
  end

  def test_finds_all_invoice_items_by_item_id
    invoice_item = InvoiceItem.find_all_by_item_id(2443)
    assert_equal 9, invoice_item.count
  end

  def test_finds_all_invoice_items_by_invoice_id
    invoice_item = InvoiceItem.find_all_by_invoice_id(1)
    assert_equal 8, invoice_item.count
  end

  def test_finds_all_invoice_items_by_quantity
    invoice_item = InvoiceItem.find_all_by_quantity(6)
    assert_equal 2116, invoice_item.count
  end

  def test_finds_all_invoice_items_by_unit_price
    invoice_item = InvoiceItem.find_all_by_unit_price(29973)
    assert_equal 4, invoice_item.count
  end

  def test_finds_all_invoice_items_by_created_at
    invoice_item = InvoiceItem.find_all_by_created_at("2012-03-27 14:54:09 utc")
    assert_equal 15, invoice_item.count
  end

  def test_finds_all_invoice_items_by_updated_at
    invoice_item = InvoiceItem.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, invoice_item.count
  end

  def test_finds_invoice_item_invoice
    invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

    invoices_file.each do |row|
      invoices << Invoice.new(row)
    end
    Invoice.store(invoices)

    invoice_items = InvoiceItem.find_by_invoice_id(1)
    invoice_items.invoice
    assert_equal 26, invoice_items.invoice.merchant_id
  end

  def test_finds_invoice_item_item
    items_file = CSV.open("./data/items.csv", headers: true)
      items = []

    items_file.each do |row|
      items << Item.new(row)
    end
    Item.store(items)

    invoice_items = InvoiceItem.find_by_item_id(539)
    invoice_items.item
    assert_equal "Item Sunt Saepe", invoice_items.item.name
  end
end
