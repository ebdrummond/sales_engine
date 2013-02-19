require 'csv'
require 'time'
 
class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(input)
    @id = input["id"].to_i
    @item_id = input["item_id"].to_i
    @invoice_id = input["invoice_id"].to_i
    @quantity = input["quantity"].to_i
    @unit_price = input["unit_price"].to_i
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def to_s
    "#{@id} #{@item_id} #{@invoice_id} #{@quantity} #{@unit_price} #{@created_at} #{@updated_at}"
  end

  def self.store(invoice_items)
    @invoice_items = invoice_items
  end

  def self.collection
    @invoice_items
  end

  def self.find_by_id(id)
    collection.find{|invoice_item| invoice_item.id == id}
  end

  def self.find_by_item_id(item_id)
    collection.find{|invoice_item| invoice_item.item_id == item_id}
  end

  def self.find_by_invoice_id(invoice_id)
    collection.find{|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def self.find_by_quantity(quantity)
    collection.find{|invoice_item| invoice_item.quantity == quantity}
  end

  def self.find_by_unit_price(unit_price)
    collection.find{|invoice_item| invoice_item.unit_price == unit_price}
  end

  def self.find_by_created_at(created_at)
    collection.find{|invoice_item| invoice_item.created_at.downcase == created_at.downcase}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|invoice_item| invoice_item.updated_at.downcase == updated_at.downcase}
  end

  def self.find_all_by_id(id)
    collection.select{|invoice_item| invoice_item.id == id}
  end

  def self.find_all_by_item_id(item_id)
    collection.select{|invoice_item| invoice_item.item_id == item_id}
  end

  def self.find_all_by_invoice_id(invoice_id)
    collection.select{|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def self.find_all_by_quantity(quantity)
    collection.select{|invoice_item| invoice_item.quantity == quantity}
  end

  def self.find_all_by_unit_price(unit_price)
    collection.select{|invoice_item| invoice_item.unit_price == unit_price}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|invoice_item| invoice_item.created_at.downcase == created_at.downcase}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|invoice_item| invoice_item.updated_at.downcase == updated_at.downcase}
  end

  def self.random
    collection.sample
  end

  def invoice
    Invoice.find_by_id(invoice_id)
  end

  def item
    Item.find_by_id(item_id)
  end

  def subtotal
    quantity * unit_price
  end
end
