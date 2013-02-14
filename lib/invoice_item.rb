require 'csv'
require 'time'
 
class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(input)
    @id = input["id"]
    @item_id = input["item_id"]
    @invoice_id = input["merchant_id"]
    @quantity = input["quantity"]
    @unit_price = input["unit_price"]
    @created_at = Time.parse(input["created_at"])
    @updated_at = Time.parse(input["updated_at"])
  end

  def to_s
    "#{@id} #{@item_id} #{@invoice_id} #{@quantity} #{@unit_price} #{@created_at} #{@updated_at}"
  end

  def self.store(invoice_items)
    @invoice_items = invoice_items
  end

  def self.all
    @invoice_items
  end

end