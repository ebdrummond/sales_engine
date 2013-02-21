require 'csv'
require 'time'
require 'date'
require 'bigdecimal'

require 'sales_engine/invoice'
require 'sales_engine/merchant'
require 'sales_engine/item'
require 'sales_engine/invoice_item'
require 'sales_engine/transaction'
require 'sales_engine/customer'
require 'sales_engine/load_files'

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
