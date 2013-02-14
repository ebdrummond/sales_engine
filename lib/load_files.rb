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

puts "********** Invoice Find By **********"
LoadFiles.load_invoices_file
puts Invoice.find_by_id(5)
puts
puts Invoice.find_by_customer_id(2)
puts
puts Invoice.find_by_merchant_id(27)
puts
puts Invoice.find_by_status("shipped")
puts
puts Invoice.find_by_created_at("2012-03-25 09:54:09 UTC")
puts
puts Invoice.find_by_updated_at("2012-03-12 05:54:09 UTC")
puts "\n********** Invoice Find All By **********"
puts Invoice.find_all_by_id(5)
puts
puts Invoice.find_all_by_customer_id(2)
puts
puts Invoice.find_all_by_merchant_id(27)
puts
puts Invoice.find_all_by_status("shipped")
puts
puts Invoice.find_all_by_created_at("2012-03-25 09:54:09 UTC")
puts
puts Invoice.find_all_by_updated_at("2012-03-12 05:54:09 UTC")
puts "\n********** Invoice Randoms **********"
puts Invoice.random

puts "\n************************************************************"

puts "********** Transaction Find By **********"
LoadFiles.load_transactions_file

puts Transaction.find_by_id(1)
puts
puts Transaction.find_by_invoice_id(10)
puts
puts Transaction.find_by_credit_card_number(4540842003561938)
puts
puts Transaction.find_by_credit_card_expiration_date
puts
puts Transaction.find_by_result("success")
puts
puts Transaction.find_by_created_at("2012-03-27 14:54:10 UTC")
puts
puts Transaction.find_by_updated_at("2012-03-27 14:54:10 UTC")

puts "\n ********** Transaction Find All By **********"
LoadFiles.load_transactions_file

puts Transaction.find_all_by_id(1)
puts
puts Transaction.find_all_by_invoice_id(10)
puts
puts Transaction.find_all_by_credit_card_number(4540842003561938)
puts
puts Transaction.find_all_by_credit_card_expiration_date
puts
puts Transaction.find_all_by_result("success")
puts
puts Transaction.find_all_by_created_at("2012-03-27 14:54:10 UTC")
puts
puts Transaction.find_all_by_updated_at("2012-03-27 14:54:10 UTC")

puts "\n********** Transactions Randoms **********"
puts Transaction.random

puts "\n************************************************************"

puts "********** Item Find By **********"
LoadFiles.load_items_file

puts Item.find_by_id(1)
puts
puts Item.find_by_name("Item Nemo Facere")
puts
puts Item.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
puts
puts Item.find_by_unit_price(32301)
puts
puts Item.find_by_merchant_id(1)
puts
puts Item.find_by_created_at("2012-03-27 14:53:59 UTC")
puts
puts Item.find_by_updated_at("2012-03-27 14:53:59 UTC")

puts "********** Item Find All By **********"
LoadFiles.load_items_file

puts Item.find_all_by_id(1)
puts
puts Item.find_all_by_name("Item Nemo Facere")
puts
puts Item.find_all_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
puts
puts Item.find_all_by_unit_price(32301)
puts
puts Item.find_all_by_merchant_id(1)
puts
puts Item.find_all_by_created_at("2012-03-27 14:53:59 UTC")
puts
puts Item.find_all_by_updated_at("2012-03-27 14:53:59 UTC")

puts "********** Item Find Random **********"
puts Item.random

puts "\n************************************************************"

puts "\n********** Merchant Find By **********"
LoadFiles.load_merchants_file

puts Merchant.find_by_id(3)
puts
puts Merchant.find_by_name("Klein, Rempel and Jones")
puts
puts Merchant.find_by_created_at("2012-03-27 14:53:59 UTC")
puts
puts Merchant.find_by_updated_at("2012-03-27 14:53:59 UTC")
puts
puts Merchant.find_all_by_id(8)
puts
puts Merchant.find_all_by_name("Williamson Group")
puts

# LoadFiles.load_items_file
# puts Item.all
# LoadFiles.load_customers_file
# puts Customer.all
# LoadFiles.load_invoice_items_file
# puts InvoiceItem.all
# LoadFiles.load_transactions_file
# puts Transaction.all

