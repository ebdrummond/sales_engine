require 'csv'
require_relative 'invoice'
require_relative 'merchant'
require_relative 'item'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'customer'

class LoadFiles

  def self.load_invoices_file
    invoices_file = CSV.open("../data/test_invoices.csv", headers: true)
    invoices = []

    invoices_file.each do |row|
      invoices << Invoice.new(row)
    end
    Invoice.store(invoices)
  end

  def self.load_merchants_file
    merchants_file = CSV.open("../data/test_merchants.csv", headers: true)
    merchants = []

    merchants_file.each do |row|
      merchants << Merchant.new(row)
    end
    Merchant.store(merchants)
  end

  def self.load_items_file
    items_file = CSV.open("../data/test_items.csv", headers: true)
    items = []

    items_file.each do |row|
      items << Item.new(row)
    end
    Item.store(items)
  end

  def self.load_customers_file
    customers_file = CSV.open("../data/test_customers.csv", headers: true)
    customers = []

    customers_file.each do |row|
      customers << Customer.new(row)
    end
    Customer.store(customers)
  end

  def self.load_invoice_items_file
    invoice_items_file = CSV.open("../data/test_invoice_items.csv", headers: true)
    invoice_items = []

    invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
    end
    InvoiceItem.store(invoice_items)
  end

  def self.load_transactions_file
    transactions_file = CSV.open("../data/test_transactions.csv", headers: true)
    transactions= []

    transactions_file.each do |row|
      transactions<< Transaction.new(row)
    end
    Transaction.store(transactions)
  end
end

LoadFiles.load_merchants_file
LoadFiles.load_items_file
LoadFiles.load_invoices_file
LoadFiles.load_customers_file
LoadFiles.load_transactions_file
LoadFiles.load_invoice_items_file
puts
merchant = Merchant.find_by_id(8)
puts merchant.items
puts
merchant = Merchant.find_by_id(27)
puts merchant.invoices
puts "******* Rel 12 *******"
customer = Customer.find_by_id(1)
puts
puts customer.invoices
puts "******* Rel 11 *******"
transaction = Transaction.find_by_invoice_id(5)
puts transaction.invoice
puts "******* Rel 10 *******"
item = Item.find_by_merchant_id(1)
puts item.merchant
puts "******* Rel 9 *******"
item = Item.find_by_id(1)
puts item.invoice_items
puts "******* Rel 8 *******"
invoice_item = InvoiceItem.find_by_item_id(1)
puts invoice_item.item
puts "******* Rel 7 *******"
invoice_item = InvoiceItem.find_by_invoice_id(5)
puts invoice_item.invoice
puts "******* Rel 6 *******"
invoice = Invoice.find_by_customer_id(1)
puts invoice.customer











