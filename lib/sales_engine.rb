require_relative './sales_engine/load_files'

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
date = Date.parse "Tue, 20 Mar 2012"
puts SalesEngine::Merchant.revenue(date)
