require 'csv'
require_relative 'invoice'
require_relative 'merchant'
require_relative 'item'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'customer'

class LoadFiles

  def self.load_invoices_file
    invoices_file = CSV.open("../data/invoices.csv", headers: true)
    invoices = []

    invoices_file.each do |row|
      invoices << Invoice.new(row)
    end
    Invoice.store(invoices)
  end

  def self.load_merchants_file
    merchants_file = CSV.open("../data/merchants.csv", headers: true)
    merchants = []

    merchants_file.each do |row|
      merchants << Merchant.new(row)
    end
    Merchant.store(merchants)
  end

  def self.load_items_file
    items_file = CSV.open("../data/items.csv", headers: true)
    items = []

    items_file.each do |row|
      items << Item.new(row)
    end
    Item.store(items)
  end

  def self.load_customers_file
    customers_file = CSV.open("../data/customers.csv", headers: true)
    customers = []

    customers_file.each do |row|
      customers << Customer.new(row)
    end
    Customer.store(customers)
  end

  def self.load_invoice_items_file
    invoice_items_file = CSV.open("../data/invoice_items.csv", headers: true)
    invoice_items = []

    invoice_items_file.each do |row|
      invoice_items << InvoiceItem.new(row)
    end
    InvoiceItem.store(invoice_items)
  end

  def self.load_transactions_file
    transactions_file = CSV.open("../data/transactions.csv", headers: true)
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
# puts
# merchant = Merchant.find_by_id(8)
# puts merchant.items
# puts
# merchant = Merchant.find_by_id(27)
# puts merchant.invoices
# puts "******* Rel 12 *******"
# customer = Customer.find_by_id(29)
# puts
# puts customer.invoices
# puts "******* Rel 11 *******"
# transaction = Transaction.find_by_id(29)
# puts transaction.invoice
# puts "******* Rel 10 *******"
# item = Item.find_by_id(29)
# puts item.merchant
# puts "******* Rel 9 *******"
# item = Item.find_by_id(29)
# puts item.invoice_items
# puts "******* Rel 8 *******"
# invoice_item = InvoiceItem.find_by_item_id(1)
# puts invoice_item.item
# puts "******* Rel 7 *******"
# invoice_item = InvoiceItem.find_by_invoice_id(5)
# puts invoice_item.invoice
# puts "******* Rel 6 *******"
# invoice = Invoice.find_by_customer_id(1)
# puts invoice.customer

# puts Merchant.most_revenue(10)

 # merchant = Merchant.find_by_id(29)
 #   puts merchant.revenue

#  puts Merchant.most_revenue(100)
# puts
#  merchant = Merchant.find_by_id(14)
#  puts merchant.revenue
# puts 
#  merchant = Merchant.find_by_id(84)
#  puts merchant.revenue
#  puts
#   merchant = Merchant.find_by_id(6)
#  puts merchant.revenue

# merchant = Merchant.find_by_id(29)
# puts merchant.revenue("2012-03-22")


# puts Merchant.revenue("2012-03-08")
# a = Time.new
# merchant = Merchant.find_by_name("Dicki-Bednar")
# puts merchant.revenue
# b = Time.new
# puts b-a

# merchant2 = Merchant.find_by_name("Willms and Sons")
# puts merchant2.revenue("2012-03-09")
# puts merchant.successful_transactions

# merchant = Merchant.find_by_id(13)
# puts merchant.customers_with_pending_invoices

# customer = Customer.find_by_id(29)
# puts customer.transactions

# merchant = Merchant.find_by_id(29)
# puts merchant.favorite_customer



# puts item = Item.most_revenue(10)
# puts
# puts
# puts
# puts
# item = Item.find_by_id(227)
# puts item.revenue
# puts
# item = Item.find_by_id(2174)
# puts item.revenue
# puts
# item = Item.find_by_id(848)
# puts item.revenue

# puts Item.most_items(10)
# puts
# puts
# puts
# puts Item.find_by_id(227).item_count
# puts
# item = Item.find_by_id(2174)
# puts item.item_count
# puts
# item = Item.find_by_id(1396)
# puts item.item_count

# item = Item.find_by_id(227)
# puts item.items_sold_per_day
# puts item.best_day

# invoice = Invoice.find_by_id(29)
# puts invoice.invoice_date

# customer = Customer.find_by_id(13)
# puts customer.transactions


customer = Customer.find_by_id(29)
puts customer.transactions

# merchant = Merchant.find_by_id(29)
# puts merchant.sorted_customers_per_merchant
