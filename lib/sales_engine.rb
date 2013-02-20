require 'csv'
require 'time'
require 'bigdecimal'

require './lib/sales_engine/invoice'
require './lib/sales_engine/merchant'
require './lib/sales_engine/item'
require './lib/sales_engine/invoice_item'
require './lib/sales_engine/transaction'
require './lib/sales_engine/customer'
require './lib/sales_engine/load_files'

module SalesEngine

  def self.startup
    LoadFiles.load_merchants_file
    LoadFiles.load_items_file
    LoadFiles.load_invoices_file
    LoadFiles.load_customers_file
    LoadFiles.load_transactions_file
    LoadFiles.load_invoice_items_file
  end
end

SalesEngine.startup
