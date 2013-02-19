require 'csv'
require 'time'
# require 'lib/load_files'


class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(input)
    @id = input["id"].to_i
    @name = input["name"]
    @description = input["description"]
    @unit_price = input["unit_price"].to_i
    @merchant_id = input["merchant_id"].to_i
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def to_s
    "#{@id} #{@name} #{@description} #{@unit_price} #{@merchant_id} #{@created_at} #{@updated_at}"
  end

  def self.store(items)
    @items = items
  end

  def self.collection
    @items
  end

  # ***************************** Find By *****************************

  def self.find_by_id(id)
    collection.find{|item| item.id == id}
  end

  def self.find_by_name(name)
    collection.find{|item| item.name.downcase == name.downcase}
  end

  def self.find_by_description(description)
    collection.find{|item| item.description.downcase == description.downcase}
  end

  def self.find_by_unit_price(unit_price)
    collection.find{|item| item.unit_price == unit_price}
  end

  def self.find_by_merchant_id(merchant_id)
    collection.find{|item| item.merchant_id == merchant_id}
  end

  def self.find_by_created_at(created_at)
    collection.find{|item| item.created_at.downcase == created_at.downcase}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|item| item.updated_at.downcase == updated_at.downcase}
  end

  # ***************************** Find All By *****************************

  def self.find_all_by_id(id)
    collection.select{|item| item.id == id}
  end

  def self.find_all_by_name(name)
    collection.select{|item| item.name.downcase == name.downcase}
  end

  def self.find_all_by_description(description)
    collection.select{|item| item.description.downcase == description.downcase}
  end

  def self.find_all_by_unit_price(unit_price)
    collection.select{|item| item.unit_price == unit_price}
  end

  def self.find_all_by_merchant_id(merchant_id)
    collection.select{|item| item.merchant_id == merchant_id}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|item| item.created_at.downcase == created_at.downcase}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|item| item.updated_at.downcase == updated_at.downcase}
  end  

  # ***************************** Find Random *****************************

  def self.random
    collection.sample
  end

  def merchant
    Merchant.find_by_id(merchant_id)
  end

  def invoice_items
    InvoiceItem.find_all_by_item_id(id)
  end

  def invoices
    invoices = []
    invoice_items.each do |invoice_item|
      invoices << invoice_item.invoice
    end
    invoices
  end

  def revenue
    grand_total = 0
    invoices.each do |invoice|
      if invoice.paid?
        grand_total = grand_total + invoice.total
        end
      end
    grand_total
  end

  def self.most_revenue(number)
    highest_earners = collection.sort_by{|item| item.revenue}
    highest_earners.reverse[0..number-1]
  end

  def item_count
    grand_total = 0
      invoices.each do |invoice|
      if invoice.paid?
        invoice.invoice_items.each do |invoice_item|
        grand_total = invoice_item.quantity + grand_total
        end
      end
    end
    grand_total
  end

  def self.most_items(number)
    highest_sellers = collection.sort_by{|item| item.item_count}
    highest_sellers.reverse[0..number-1]
  end

  def items_sold_per_day
    items_per_day = Hash.new(0)
    invoice_items.each do |invoice_item|
      items_per_day[invoice_item.invoice.invoice_date] += invoice_item.quantity
    end
    items_per_day
  end

  def best_day
    items_sold_per_day.max_by{|invoice_date, quantity| quantity}[0]
  end
end
