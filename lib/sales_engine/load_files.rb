module SalesEngine
  class LoadFiles

    def self.load_invoices_file
      invoices_file = CSV.open("./data/invoices.csv", headers: true)
      invoices = []

      invoices_file.each do |row|
        invoices << Invoice.new(row)
      end
      Invoice.store(invoices)
    end

    def self.load_merchants_file
      merchants_file = CSV.open("./data/merchants.csv", headers: true)
      merchants = []

      merchants_file.each do |row|
        merchants << Merchant.new(row)
      end
      Merchant.store(merchants)
    end

    def self.load_items_file
      items_file = CSV.open("./data/items.csv", headers: true)
      items = []

      items_file.each do |row|
        items << Item.new(row)
      end
      Item.store(items)
    end

    def self.load_customers_file
      customers_file = CSV.open("./data/customers.csv", headers: true)
      customers = []

      customers_file.each do |row|
        customers << Customer.new(row)
      end
      Customer.store(customers)
    end

    def self.load_invoice_items_file
      invoice_items_file = CSV.open("./data/invoice_items.csv", headers: true)
      invoice_items = []

      invoice_items_file.each do |row|
        invoice_items << InvoiceItem.new(row)
      end
      InvoiceItem.store(invoice_items)
    end

    def self.load_transactions_file
      transactions_file = CSV.open("./data/transactions.csv", headers: true)
      transactions= []

      transactions_file.each do |row|
        transactions<< Transaction.new(row)
      end
      Transaction.store(transactions)
    end
  end
end
