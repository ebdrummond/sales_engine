module SalesEngine
  class Invoice

    attr_reader :id, :customer_id, :merchant_id, :status,
                      :created_at, :updated_at

    def initialize(input)
      @id = input["id"].to_i
      @customer_id = input["customer_id"].to_i
      @merchant_id = input["merchant_id"].to_i
      @status = input["status"]
      @created_at = Date.parse(input["created_at"]).strftime("%Y-%m-%d")
      @updated_at = Date.parse(input["updated_at"])
    end

    def to_s
      [@id, @customer_id, @merchant_id, @status,
        @created_at, @updated_at
      ].join(" ")
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
      collection.find{|invoice| invoice.created_at == created_at}
    end

    def self.find_by_updated_at(updated_at)
      collection.find{|invoice| invoice.updated_at == updated_at}
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
      collection.select{|invoice| invoice.created_at == created_at}
    end

    def self.find_all_by_updated_at(updated_at)
      collection.select{|invoice| invoice.updated_at == updated_at}
    end
  # ***************************** Find Random *****************************

    def self.random
      collection.sample
    end

    def transactions
      Transaction.find_all_by_invoice_id(id)
    end

    def paid?
      @paid ||= transactions.any?{|transaction| transaction.successful? }
    end

    def valid_invoices
      transactions.select{|transaction| transaction.successful? }
    end

    def total
      if self.paid?
        sum = invoice_items.collect do |invoice_item|
          invoice_item.subtotal end
          sum.inject(:+) || 0
      else
        sum = 0
      end
      BigDecimal.new(sum/100.0, 12)
    end

    def invoice_items
      InvoiceItem.find_all_by_invoice_id(id)
    end

    def item_count
      inv_item = invoice_items.collect do |invoice_item|
        invoice_item.quantity end
        inv_item.inject(:+) || 0
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
      collection.count + 1
    end

    def self.create(input)
      invoice = Invoice.new(
          {"id" => generate_id,
          "customer_id" => input[:customer].id,
          "merchant_id" => input[:merchant].id,
          "status" => input[:status],
          "created_at" => Time.now.to_s,
          "updated_at" => Time.now.to_s})

      @invoices << invoice

      items = input[:items]
      items_count = Hash.new(0)
      items.each do |item|
        items_count[item] = items_count[item] + 1
      end

      items_count.each do |item, quantity|
         InvoiceItem.create(
                                      :invoice_id => invoice.id,
                                      :item_id     => item.id,
                                      :unit_price => item.unit_price,
                                      :quantity    => quantity
                                      )
      end

      return invoice
    end

    def charge(input)
      credit_card_number = input[:credit_card_number]
      credit_card_expiration = input[:credit_card_expiration]
      result = input[:result]

      Transaction.create(
        :credit_card_number => credit_card_number,
        :credit_card_expiration => credit_card_expiration,
        :result => result,
        :invoice_id => id
          )
    end
  end
end
