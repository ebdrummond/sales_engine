require 'csv'
require 'time'
require './lib/invoice_item'

class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(input)
    @id = input["id"].to_i
    @customer_id = input["customer_id"].to_i
    @merchant_id = input["merchant_id"].to_i
    @status = input["status"]
    @created_at = Time.parse(input["created_at"]).to_s
    @updated_at = Time.parse(input["updated_at"]).to_s
  end

  def to_s
    "#{@id} #{@customer_id} #{@merchant_id} #{@status} #{@created_at} #{@updated_at}"
  end

  def self.store(invoices)
    @invoices = invoices
  end

  def self.collection
    @invoices
  end
# ***************************** Find By *****************************

  def self.find_by_id(id)
    collection.find{|invoice| invoice.id == id}
  end

  def self.find_by_customer_id(customer_id)
    collection.find{|invoice| invoice.customer_id == customer_id}
  end

  def self.find_by_merchant_id(merchant_id)
    collection.find{|invoice| invoice.merchant_id == merchant_id}
  end

  def self.find_by_status(status)
    collection.find{|invoice| invoice.status.downcase == status.downcase}
  end

  def self.find_by_created_at(created_at)
    collection.find{|invoice| invoice.created_at.downcase == created_at.downcase}
  end

  def self.find_by_updated_at(updated_at)
    collection.find{|invoice| invoice.updated_at.downcase == updated_at.downcase}
  end
# ***************************** Find All By *****************************
  def self.find_all_by_id(id)
    collection.select{|invoice| invoice.id == id}
  end

  def self.find_all_by_customer_id(customer_id)
    collection.select{|invoice| invoice.customer_id == customer_id}
  end

  def self.find_all_by_merchant_id(merchant_id)
    collection.select{|invoice| invoice.merchant_id == merchant_id}
  end

  def self.find_all_by_status(status)
    collection.select{|invoice| invoice.status.downcase == status.downcase}
  end

  def self.find_all_by_created_at(created_at)
    collection.select{|invoice| invoice.created_at.downcase == created_at.downcase}
  end

  def self.find_all_by_updated_at(updated_at)
    collection.select{|invoice| invoice.updated_at.downcase == updated_at.downcase}
  end
# ***************************** Find Random *****************************

  def self.random
    collection.sample
  end

  def transactions
    Transaction.find_all_by_invoice_id(id)
  end

  def paid?
    transactions.any?{|transaction| transaction.successful? }
  end

  def total
    total = 0
    subtotals = invoice_items.collect{|invoice_item| invoice_item.subtotal }
    subtotals.each do |subtotal|
      total = total + subtotal
    end
    return total
  end

  def invoice_items
    InvoiceItem.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.collect{|invoice_item| invoice_item.item}
  end

  def customer
    Customer.find_by_id(customer_id)
  end

  def invoice_date
    Time.parse(created_at).strftime("%Y-%m-%d")
  end

  def self.count
    collection.count
  end

  def self.generate_id
    collection.count +2
  end

  def self.create(input)
    invoice = Invoice.new({"id" => generate_id,
                                        "customer_id" => input[:customer].id,
                                        "merchant_id" => input[:merchant].id,
                                        "created_at" => Time.now.to_s, 
                                        "updated_at" => Time.now.to_s})
    input[:items].each do |item|
      InvoiceItem.create(:invoice_id => invoice.id, :item_id =>item.id)
    end
    collection << invoice
    invoice
  end

end



